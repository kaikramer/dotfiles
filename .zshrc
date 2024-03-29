#zmodload zsh/zprof

# disable terminal flow control in mintty -> frees Ctrl-S and Ctrl-Q shortcuts
stty -ixon

[[ ! -f ~/.dircolors ]] || eval `dircolors ~/.dircolors`
[[ ! -f ~/.work ]]      || source ~/.work

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
#if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
#fi

# Optimize slow compinit by only calling it once per day (see https://gist.github.com/ctechols/ca1035271ad134841284#gistcomment-2894219)
# To manually rebuild the cache of executable commands, use command 'rehash'
_zicompinit_custom() {
  setopt extendedglob local_options
  autoload -Uz compinit
  local zcd=${ZDOTDIR:-$HOME}/.zcompdump
  local zcdc="$zcd.zwc"
  # Compile the completion dump to increase startup speed, if dump is newer or doesn't exist,
  # in the background as this is doesn't affect the current session
  if [[ -f "$zcd"(#qN.m+1) ]]; then
        compinit -i -d "$zcd"
        { rm -f "$zcdc" && zcompile "$zcd" } &!
  else
        compinit -C -d "$zcd"
        { [[ ! -f "$zcdc" || "$zcd" -nt "$zcdc" ]] && rm -f "$zcdc" && zcompile "$zcd" } &!
  fi
}
local zcd=${ZPLGM[ZCOMPDUMP_PATH]:-${ZDOTDIR:-$HOME}/.zcompdump}

# zinit plugin manager
#source ~/.zinit/bin/zinit.zsh
source $HOME/.local/share/zinit/zinit.git/zinit.zsh
zinit ice wait lucid; zinit light urbainvaes/fzf-marks
zinit ice wait lucid; zinit light Aloxaf/fzf-tab
zinit ice wait lucid blockf atpull'zinit creinstall -q .'; zinit light zsh-users/zsh-completions
zinit ice wait lucid atinit"ZINIT[COMPINIT_OPTS]=-C; _zicompinit_custom; zicdreplay"; zinit light zdharma/fast-syntax-highlighting
zinit ice wait lucid atload"!_zsh_autosuggest_start"; zinit light zsh-users/zsh-autosuggestions

[[ ! -f ~/.fzf.zsh ]] || source ~/.fzf.zsh

# SSH/SCP autocomplete only from .ssh/config
zstyle ':completion:*' users
if [[ -r ~/.ssh/config ]]; then
    h=()
    h=(${(s. .)${${${(@M)${(f)"$(<${HOME}/.ssh/config)"}:#Host *}#Host }:#*[*?]*}})
    zstyle ':completion:*:(ssh|scp):*' hosts $h
fi

# when ssh is called, open new tmux window and name it with ssh host
ssh() {
    if env | grep -q "TMUX_PANE"; then
        tmux rename-window "$*"
        TERM=xterm-256color command ssh "$@"
        tmux set-window-option automatic-rename "on" 1>/dev/null
    else
        TERM=xterm-256color command ssh "$@"
    fi
}

# redefine SSH completion function and remove every source but ~/.ssh/config
_fzf_complete_ssh() {
  _fzf_complete +m -- "$@" < <(
    setopt localoptions nonomatch
    command cat <(cat ~/.ssh/config 2> /dev/null | command grep -i '^\s*host\(name\)\? ' | awk '{for (i = 2; i <= NF; i++) print $1 " " $i}' | command grep -v '[*?]') |
        awk '{if (length($2) > 0) {print $2}}' | sort -u
  )
}


# bind ssh completion to Ctrl-S
start_ssh_completion () { LBUFFER="ssh " ; fzf-completion }
zle -N start_ssh_completion
bindkey '^s' start_ssh_completion

export PATH=$HOME/bin:/usr/local/bin:$PATH

# expand after equal (e.g. x=~)
set -o magicequalsubst

# fzf-marks
export FZF_MARKS_COLOR_LHS=32
export FZF_MARKS_COLOR_RHS=34

# bat color scheme
export BAT_THEME="base16-256"

# add some key bindings from oh-my-zsh
bindkey '^[[1;5C' forward-word                        # [Ctrl-RightArrow] - move forward one word
bindkey '^[[1;5D' backward-word                       # [Ctrl-LeftArrow] - move backward one word
bindkey ' ' magic-space                               # [Space] - do history expansion
if [[ "${terminfo[kcbt]}" != "" ]]; then
  bindkey "${terminfo[kcbt]}" reverse-menu-complete   # [Shift-Tab] - move through the completion menu backwards
fi

# history
HISTFILE=~/.zsh_history
HISTSIZE=10000   # Number of commands that are loaded into memory from the history file
SAVEHIST=10000   # Number of commands that are stored in the zsh history file

# Write an entry in history file right after a command is finished (not only when the shell exits),
# but do not constantly read new entries like "SHARE_HISTORY" does (do not modify history of current shell)
setopt INC_APPEND_HISTORY_TIME

# avoid spamming history with duplicate entries
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS

export EDITOR='nvim'

# aliases
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    alias ls='ls --color=auto -v'
elif [[ "$OSTYPE" == "darwin"* ]]; then
    alias ls='ls -G'
fi
alias la='ls -la'
alias vi='nvim'
#alias n='nnn'
alias fd='fd --hidden --no-ignore'

# make directory changes faster
alias mc='mc -u'

# show timestamps in history
alias history='history -E'

alias sc='openssl x509 -noout -text -inform DER -nameopt RFC2253 -in '
alias sp='openssl x509 -noout -text -inform PEM -nameopt RFC2253 -in '
alias sl='openssl crl -noout -text -inform DER -in '
alias p12='openssl pkcs12 -in '
alias p10='openssl req -noout -text -in '
alias b64='openssl enc -d -base64 -in '

alias g='git'
alias ga='git add'
alias gb='git branch'
alias gbv='git branch -vv'
alias gc='git commit -v'
alias gco='git checkout'
alias gd='git difftool'
alias gf='git fetch --prune'
alias gl='git --no-pager log -25 --pretty=format:"%C(yellow)%h %C(green)%ad%C(auto)%d %Creset%s %C(cyan)%aN" --date=short --graph --decorate'
alias gm='git merge'
alias gp='git push'
alias gr='git reset'
alias gs='git status'

#alias ssh='TERM=xterm-256color ssh' -> integrated in ssh() function above

# use Linux colors for ls on macOS
export LSCOLORS=ExGxBxDxCxEgEdxbxgxcxd

# color output in man/less and case independent search
export LESS=-Ri
man() {
    LESS_TERMCAP_md=$'\e[01;34m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;47;30m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
}

# Misc. settings
setopt NO_AUTO_CD           # always use cd command to change directory
setopt NO_BG_NICE           # Workaround for "nice(5) failed", see https://github.com/Microsoft/WSL/issues/1887
setopt INTERACTIVE_COMMENTS # recognize comments
setopt NO_FLOW_CONTROL      # disable ⌃S to stop terminal output and ⌃Q to resume it
setopt NO_BEEP

# completion settings (see man zshoptions)
setopt AUTO_LIST                                                                           # automatically list choices on an ambiguous completion
setopt AUTO_MENU                                                                           # automatically show completion menu on successive tab press
setopt NO_LIST_AMBIGUOUS                                                                   # do not complete up to unambiguous prefix without a completion list being displayed
setopt NO_MENU_COMPLETE                                                                    # do not autoselect the first completion entry
setopt NO_COMPLETE_IN_WORD                                                                 # do not start completion when cursor is somewhere in the middle of a word
zstyle ':completion:*:*:*:*:*' menu select                                                 # select active entry in menu list with arrow keys and mark it with white background
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:::::' completer _expand _complete                                      # removed some unwanted completers: _all_matches _list _oldlist _menu _match _ignored _correct _approximate _prefix
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories   # disable named-directories autocompletion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*' # Allow for autocomplete to be case insensitive
zstyle ':completion::complete:*' use-cache on                                              # Use caching so that commands like apt and dpkg complete are useable
zstyle ':completion::complete:*' cache-path $ZSH_CACHE_DIR                                 #                       "
zstyle ':completion:*:man:*'      menu yes select                                          # man pages
zstyle ':completion:*:manuals'    separate-sections true                                   #   "
zstyle ':completion:*:manuals.*'  insert-sections   true                                   #   "
zstyle ':completion:*'            special-dirs      true
zstyle ':completion:*:processes' command 'ps aux'

# fzf-tab
zstyle ':completion:*:git-checkout:*' sort false                                # disable sort when completing `git checkout`
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}                           # set list-colors to enable filename colorizing
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'   # preview directory's content with exa when completing cd
zstyle ':fzf-tab:*' continuous-trigger '/'

# include hidden files for CTRL-T command
export FZF_DEFAULT_COMMAND='fd --type file --no-ignore --hidden --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--height=80%" # do not use --ansi it makes fzf slow

export FZF_COMPLETION_TRIGGER=''
bindkey '^T' fzf-completion
bindkey '^I' $fzf_default_completion

#bindkey '\ec' fzf-cd-widget # Alt-C

export LC_ALL="en_US.UTF-8"

# This speeds up pasting w/ autosuggest
# https://github.com/zsh-users/zsh-autosuggestions/issues/238
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}
pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish

# put current WSL ip address to Windows clipboard
ipa() {
  hostname -I | awk '{print $1}' | /mnt/c/Windows/System32/clip.exe
}

# open explorer with WSL path
explorer() {
    winpath=$(wslpath -w "$1")
    /mnt/c/Windows/explorer.exe "$winpath"
}

# hex to base64 conversion
hex2b64() {
  echo "$1" | xxd -r -p | base64
}

# hex to URL base64 conversion
hex2b64url() {
  echo "$1" | xxd -r -p | base64 | sed 's/+/-/g; s,/,_,g'
}

# decode JWT
jwt-decode() {
  jq -R 'split(".") |.[0:2] | map(@base64d) | map(fromjson)' <<< $1
}

print-colortable() {
  for colour in {1..16}
      do echo -en "\033[38;5;${colour}m38;5;${colour} \n"
  done | column -x
}

# start nnn
n() {
    # Block nesting of nnn in subshells
    if [[ "${NNNLVL:-0}" -ge 1 ]]; then
        echo "nnn is already running"
        return
    fi

    # The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set)
    # If NNN_TMPFILE is set to a custom path, it must be exported for nnn to
    # see. To cd on quit only on ^G, remove the "export" and make sure not to
    # use a custom path, i.e. set NNN_TMPFILE *exactly* as follows:
    #     NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    export NNN_TMPFILE="$HOME/.config/nnn/tmp/last_dir"

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    # The backslash allows one to alias n to nnn if desired without making an
    # infinitely recursive alias
    # -C use 8 bit colors
    # -n start in search mode
    \nnn -C "$@"

    if [ -f "$NNN_TMPFILE" ]; then
            . "$NNN_TMPFILE"
            rm -f "$NNN_TMPFILE" > /dev/null
    fi
}
zle -N n
#bindkey -s "^[c" 'n .\n'    # Alt-C
bindkey -s "^[x" 'n .\n'    # Alt-X
#bindkey '^[c' n    # Alt-C

eval "$(starship init zsh)"
#zprof
