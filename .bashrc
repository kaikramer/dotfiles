# set a fancy prompt
#PS1='\u@\h:\w\$ '
build_prompt () {
    # This needs to be first
    local EXIT_CODE="$?"
    PS1=""

    # time
    PS1+="\[\033[38;5;8m\][\A]\[$(tput sgr0)\]"

    # return code of last command
    if [ $EXIT_CODE != 0 ]; then
        PS1+=" \[\033[38;5;1m\]$EXIT_CODE\[$(tput sgr0)\]"
    fi

    # current path
    PS1+=" \[\033[38;5;12m\]\w\[$(tput sgr0)\]"

    # git branch
    local GIT_BRANCH=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/')
    if [[ $GIT_BRANCH ]]; then
        PS1+=" \[\033[38;5;3m\]$GIT_BRANCH\[$(tput sgr0)\]"
    fi

    # $
    PS1+=" \[\033[38;5;2m\]\\$\[$(tput sgr0)\] "
}
PROMPT_COMMAND=build_prompt

# check the hash before searching the PATH directories
shopt -s checkhash

# do not search the path when .-sourcing a file
shopt -u sourcepath

# Append to history instead of overwrite (don't lose history of other sessions)
shopt -s histappend

# Don't put duplicate lines in the history.
export HISTCONTROL="ignoredups"

# show timestamps in history
alias history='history -E'

# Default to human readable figures
alias df='df -h'
alias du='du -h'

alias vi=vim
alias n='nnn'
alias fd='fd --hidden --no-ignore'

# classify files in colour
alias ls='ls -hF --color=tty'
alias la='ls -la'

test -r ~/.bashrc_cygwin && source ~/.bashrc_cygwin

export EDITOR=/usr/bin/vim

alias sc='openssl x509 -noout -text -inform DER -nameopt RFC2253 -in '
alias sp='openssl x509 -noout -text -inform PEM -nameopt RFC2253 -in '
alias sl='openssl crl -noout -text -inform DER -in '
alias p12='openssl pkcs12 -in '
alias p10='openssl req -noout -text -in '
alias b64='openssl enc -d -base64 -in '

# make directory changes in mc faster
alias mc='mc -u'

#
# Git command completion and aliases
#

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

alias g='git'
__git_complete g __git_main
alias ga='git add'
alias gb='git branch'
__git_complete gb _git_branch
alias gbv='git branch -vv'
alias gc='git commit -v'
alias gco='git checkout'
__git_complete gco _git_checkout
alias gd='git difftool'
alias gf='git fetch --prune'
alias gl='git --no-pager log -25 --pretty=tformat:"%C(yellow)%h %C(green)%ad%C(auto)%d %Creset%s %C(cyan)%aN" --date=short --graph --decorate'
__git_complete gl _git_log
alias gm='git merge'
__git_complete gm _git_merge
alias gp='git push'
__git_complete gp _git_push
alias gr='git reset'
__git_complete gr _git_reset
alias gs='git status'
alias gsh='git show'

