# set a fancy prompt
PS1='\u@\h:\w\$ '

# Make bash append rather than overwrite the history on disk
# shopt -s histappend

# check the hash before searching the PATH directories
shopt -s checkhash

# do not search the path when .-sourcing a file
shopt -u sourcepath

# Don't put duplicate lines in the history.
export HISTCONTROL="ignoredups"

# Default to human readable figures
alias df='df -h'
alias du='du -h'

alias vi=vim

# classify files in colour
alias ls='ls -hF --color=tty'
alias la='ls -la'

# openssl
alias sc='openssl x509 -noout -text -inform DER -nameopt RFC2253 -in '
alias sp='openssl x509 -noout -text -inform PEM -nameopt RFC2253 -in '
alias sl='openssl crl -noout -text -inform DER -in '
alias p12='openssl pkcs12 -in '
alias p10='openssl req -noout -text -in '
alias b64='openssl enc -d -base64 -in '

test -r .bashrc_cygwin && source .bashrc_cygwin
