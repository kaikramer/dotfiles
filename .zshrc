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

# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# Avoid spamming history with duplicate entries
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS

export EDITOR='nvim'

# Aliases
alias la='ls -la'
alias ls='ls --color=auto'
alias vi=nvim

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
alias gl='git pull'
alias glg='git log --stat'
alias glo='git log --oneline --decorate'
alias gm='git merge'
alias gp='git push'
alias gst='git status'

#alias ssh='TERM=xterm-256color ssh' -> integrated in ssh() function above

# Use Linux colors for ls on macOS
export LSCOLORS=ExGxBxDxCxEgEdxbxgxcxd

# Completion settings
unsetopt menu_complete   # do not autoselect the first completion entry
unsetopt flowcontrol
setopt auto_menu         # show completion menu on successive tab press
setopt complete_in_word
setopt always_to_end
setopt no_list_ambiguous
setopt MENU_COMPLETE
unset CASE_SENSITIVE HYPHEN_INSENSITIVE
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' special-dirs true
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
# disable named-directories autocompletion
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories
# Use caching so that commands like apt and dpkg complete are useable
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path $ZSH_CACHE_DIR
# Allow for autocomplete to be case insensitive
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|?=** r:|?=**'

# Workaround for "nice(5) failed", see https://github.com/Microsoft/WSL/issues/1887
unsetopt BG_NICE

# recognize comments
setopt interactivecomments

# include hidden files for CTRL-T command
export FZF_CTRL_T_COMMAND="find . -type f -not -path '*/\.git/*'"

# Let "ssh <TAB>" start completion (no "**" required)
#export FZF_COMPLETION_TRIGGER=""

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
