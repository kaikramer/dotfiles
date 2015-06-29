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

test -r ~/.bashrc_cygwin && source ~/.bashrc_cygwin

export EDITOR=/usr/bin/vim

# openssl
function osl () 
{ 
    local __INFORM="";
    local __FNAME="";
    local __OPTSAFTER="";
    local __CMD="";
    if [[ $1 == "-?" ]]; then
        echo "
     OSL shorthand for openssl, user does not need to provide the -inform
         parameter

         works like this   osl [x|c] <filename> <further_args>
         e.g.   osl x myCert -subject
         prints out the subjectname
         works only with x509,  crl, asn1parse";
        return 0;
    fi;
    if [[ $# -lt 2 ]]; then
        echo "ERROR: Arguments are missing." 1>&2;
        return 1;
    fi;
    __CMD=$1;
    shift;
    __FNAME="$1";
    shift;
    __OPTSAFTER=$*;
    if [[ $__CMD == "A" || $__CMD == "a" ]]; then
        __CMD=asn1parse;
    fi;
    if [[ $__CMD == "X" || $__CMD == "x" ]]; then
        __CMD=x509;
    fi;
    if [[ $__CMD == "C" || $__CMD == "c" ]]; then
        __CMD=crl;
    fi;
    if [[ -n $(grep -e  "-----BEGIN" "$__FNAME" ) ]]; then
        __INFORM=PEM;
    else
        __INFORM=DER;
    fi;
    openssl $__CMD -in "$__FNAME" -inform $__INFORM $__OPTSAFTER -noout -text -nameopt RFC2253
}

alias sc='openssl x509 -noout -text -inform DER -nameopt RFC2253 -in '
alias sp='openssl x509 -noout -text -inform PEM -nameopt RFC2253 -in '
alias sl='openssl crl -noout -text -inform DER -in '
alias p12='openssl pkcs12 -in '
alias p10='openssl req -noout -text -in '
alias b64='openssl enc -d -base64 -in '
