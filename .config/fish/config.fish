if status is-interactive
    set -U fish_greeting ""

    alias la="ls -la"
    alias vi="nvim"
    alias fd="fdfind --hidden --no-ignore "
    alias cat="batcat -p -P"
    alias exa="exa -la --git"

    abbr sc 'openssl x509 -noout -text -inform DER -nameopt RFC2253 -in '
    abbr sp 'openssl x509 -noout -text -inform PEM -nameopt RFC2253 -in '
    abbr sl 'openssl crl -noout -text -inform DER -in '
    abbr p12 'openssl pkcs12 -in '
    abbr p10 'openssl req -noout -text -in '
    abbr b64 'openssl enc -d -base64 -in '

    abbr g git
    abbr ga 'git add'
    abbr gb 'git branch'
    abbr gbv 'git branch -vv'
    abbr gc 'git commit -v'
    abbr gco 'git checkout'
    abbr gd 'git diff'
    abbr gf 'git fetch --prune'
    abbr gl 'git --no-pager log -25 --pretty=format:"%C(yellow)%h %C(green)%ad%C(auto)%d %Creset%s %C(cyan)%aN" --date short --graph --decorate'
    abbr gm 'git merge'
    abbr gp 'git push'
    abbr gr 'git reset'
    abbr gs 'git status'

    # use Linux colors for ls on macOS
    set -gx LSCOLORS "ExGxBxDxCxEgEdxbxgxcxd"

    # fzf
    #set -gx FZF_DEFAULT_COMMAND 'rg --files --hidden --glob "!.git/*"'
    set -gx FZF_DEFAULT_COMMAND 'fd --type file --no-ignore --hidden --exclude .git'
    set -gx FZF_CTRL_T_COMMAND  "$FZF_DEFAULT_COMMAND"
    set -gx FZF_DEFAULT_OPTS    "--height=80% --layout=reverse " # do not use --ansi it makes fzf slow
    function fish_user_key_bindings
        fzf_key_bindings
    end

    # ssh completion with fzf
    function fssh -d "Fuzzy-find ssh host and ssh into it"
        rg --ignore-case '^host [^*]' ~/.ssh/config | cut -d ' ' -f 2- --output-delimiter=\n | sort | uniq -u | fzf | read -l result; and ssh "$result"
    end
    bind \cs fssh

    # git commit history with fzf
    function gch -d "Git commit history with fzf"
        set -l log_line_to_hash "echo {} | grep -o '[a-f0-9]\{7\}' | head -1"
        set -l view_commit "$log_line_to_hash | xargs -I % sh -c 'git show --color=always % | diff-so-fancy | less -R'"
        set -l copy_commit_hash "$log_line_to_hash | xsel --clipboard"
        set -l git_checkout "$log_line_to_hash | xargs -I % sh -c 'git checkout %'"

        git log --color=always --format='%C(auto)%h%d %s %C(green)%C(bold)%cr% C(blue)%an' | \
            fzf --no-sort --reverse --tiebreak=index --no-multi --ansi \
            --preview="$view_commit" \
            --header="ENTER to view, CTRL-Y to copy hash, CTRL-X to checkout, CTRL-C to exit" \
            --bind "enter:execute:$view_commit" \
            --bind "ctrl-y:execute:$copy_commit_hash" \
            --bind "ctrl-x:execute:$git_checkout"
    end

    if test -e ~/.work.fish; source ~/.work.fish; end

    # zoxide
    zoxide init fish | source
    abbr cd z
    bind \cx zi

    starship init fish | source
end
