if status is-interactive

  set -U fish_greeting

  alias cat="batcat -p -P"
  alias exa="exa -la --git"
  alias la="ls -la"
  alias vi="nvim"
  alias fd="fdfind --hidden --no-ignore "

  abbr sc 'openssl x509 -noout -text -inform DER -nameopt RFC2253 -in '
  abbr sp 'openssl x509 -noout -text -inform PEM -nameopt RFC2253 -in '
  abbr sl 'openssl crl -noout -text -inform DER -in '
  abbr p12 'openssl pkcs12 -in '
  abbr p10 'openssl req -noout -text -in '
  abbr b64 'openssl enc -d -base64 -in '

  abbr g 'git'
  abbr ga 'git add'
  abbr gb 'git branch'
  abbr gbv 'git branch -vv'
  abbr gc 'git commit -v'
  abbr gco 'git checkout'
  abbr gd 'git difftool'
  abbr gf 'git fetch --prune'
  abbr gl 'git --no-pager log -25 --pretty=format:"%C(yellow)%h %C(green)%ad%C(auto)%d %Creset%s %C(cyan)%aN" --date short --graph --decorate'
  abbr gm 'git merge'
  abbr gp 'git push'
  abbr gr 'git reset'
  abbr gs 'git status'

  set -gx FZF_DEFAULT_COMMAND 'rg --files --hidden --glob "!.git/*"'

  # add fzf key bindings
  function fish_user_key_bindings
    fzf_key_bindings
  end

  # ssh completion
  function fssh -d "Fuzzy-find ssh host and ssh into it"
    rg --ignore-case '^host [^*]' ~/.ssh/config | cut -d ' ' -f 2- --output-delimiter=\n | sort | uniq -u | fzf | read -l result; and ssh "$result"
  end
  bind \cs 'fssh'

  source ~/.work.fish

  starship init fish | source
end
