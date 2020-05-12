#zmodload zsh/zprof

# disable terminal flow control in mintty -> frees Ctrl-S and Ctrl-Q shortcuts
stty -ixon

[[ ! -f ~/.dircolors ]] || eval `dircolors ~/.dircolors`
[[ ! -f ~/.work ]]      || source ~/.work

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Optimize slow compinit by only calling it once per day (see https://gist.github.com/ctechols/ca1035271ad134841284#gistcomment-2894219)
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
source ~/.zinit/bin/zinit.zsh
zinit ice lucid atload'source ~/.p10k.zsh' nocd; zinit light romkatv/powerlevel10k
zinit ice wait lucid; zinit light urbainvaes/fzf-marks
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

# rename tmux window with ssh host
ssh() {
    if env | grep -q "TMUX_PANE"; then
        tmux rename-window "$*"
        TERM=xterm-256color command ssh "$@"
        tmux set-window-option automatic-rename "on" 1>/dev/null
    else
        TERM=xterm-256color command ssh "$@"
    fi
}

# bind ssh completion to Ctrl-S
start_ssh_completion () { LBUFFER="ssh **" ; fzf-completion }
zle -N start_ssh_completion
bindkey '^s' start_ssh_completion

export PATH=$HOME/bin:/usr/local/bin:$PATH

set -o magicequalsubst

# fzf-marks
export FZF_MARKS_COLOR_LHS=32
export FZF_MARKS_COLOR_RHS=34

# add some key bindings from oh-my-zsh
bindkey '^[[1;5C' forward-word                        # [Ctrl-RightArrow] - move forward one word
bindkey '^[[1;5D' backward-word                       # [Ctrl-LeftArrow] - move backward one word
bindkey ' ' magic-space                               # [Space] - do history expansion
if [[ "${terminfo[kcbt]}" != "" ]]; then
  bindkey "${terminfo[kcbt]}" reverse-menu-complete   # [Shift-Tab] - move through the completion menu backwards
fi

# history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY

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
alias fd='fd --hidden --no-ignore'

alias sc='openssl x509 -noout -text -inform DER -nameopt RFC2253 -in '
alias sp='openssl x509 -noout -text -inform PEM -nameopt RFC2253 -in '
alias sl='openssl crl -noout -text -inform DER -in '
alias p12='openssl pkcs12 -in '
alias p10='openssl req -noout -text -in '
alias b64='openssl enc -d -base64 -in '

alias g='git'
alias ga='git add'
alias gc='git commit -v'
alias gd='git difftool'
alias gf='git fetch'
alias gl='git pull --rebase'
alias glg='git log --oneline --graph'
alias glo='git log --oneline --decorate'
alias gm='git merge'
alias gp='git push'
alias gst='git status'

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

# include hidden files for CTRL-T command
export FZF_DEFAULT_COMMAND='fd --type file --no-ignore --hidden --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--ansi"

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

#zprof
