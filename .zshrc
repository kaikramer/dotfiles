#zmodload zsh/zprof

# disable terminal flow control in mintty -> frees Ctrl-S and Ctrl-Q shortcuts
stty -ixon

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# zinit plugin manager
source ~/.zinit/bin/zinit.zsh
zinit ice depth=1;                                          zinit light romkatv/powerlevel10k
zinit ice wait lucid;                                       zinit light urbainvaes/fzf-marks
zinit ice wait lucid blockf atpull'zinit creinstall -q .';  zinit light zsh-users/zsh-completions
zinit ice wait lucid atinit"zpcompinit; zpcdreplay";        zinit light zsh-users/zsh-syntax-highlighting
zinit ice wait lucid atload"_zsh_autosuggest_start";        zinit light zsh-users/zsh-autosuggestions

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[[ ! -f ~/.fzf.zsh ]] || source ~/.fzf.zsh

[[ ! -f ~/.dircolors ]] || eval `dircolors ~/.dircolors`

[[ ! -f ~/.work ]] || source ~/.work

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

export FZF_MARKS_COLOR_LHS=32
export FZF_MARKS_COLOR_RHS=34

# Avoid spamming history with duplicate entries
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS

export EDITOR='nvim'

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

# Highlight the current autocomplete option
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Workaround for "nice(5) failed", see https://github.com/Microsoft/WSL/issues/1887
unsetopt BG_NICE

# Allow for autocomplete to be case insensitive
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|?=** r:|?=**'

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
