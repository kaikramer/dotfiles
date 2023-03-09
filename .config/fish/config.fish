if status is-interactive
  # Commands to run in interactive sessions can go here

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

  set -x FZF_DEFAULT_COMMAND 'rg --files --hidden --glob "!.git/*"'

  starship init fish | source
end
