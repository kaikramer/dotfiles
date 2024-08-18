if status is-interactive
    set -U fish_greeting ""

    alias la="LC_COLLATE=C ls -la"
    alias vi="nvim"
    alias fd="fd --hidden --no-ignore "
    alias cat="batcat -p -P"
    alias exa="exa -la --git"

    abbr vifi 'vi ~/.config/fish/config.fish'

    abbr sc 'openssl x509 -noout -text -nameopt RFC2253 -inform DER -in '
    abbr sp 'openssl x509 -noout -text -nameopt RFC2253 -inform PEM -in '
    abbr sl 'openssl crl -noout -text -nameopt RFC2253 -inform DER -in '
    abbr p12 'openssl pkcs12 -in '
    abbr p10 'openssl req -noout -text -in '
    abbr b64 'openssl enc -d -base64 -in '

    abbr g git
    abbr ga 'git-forgit add'
    abbr gb 'git branch'
    abbr gbv 'git branch -vv'
    abbr gc 'git commit -v -m'
    # abbr gco 'git checkout'
    abbr gco 'git-forgit checkout_branch'
    abbr gd 'git-forgit diff'
    abbr gf 'git fetch --prune'
    abbr gl 'git --no-pager log -25 --pretty=format:"%C(yellow)%h %C(green)%ad%C(auto)%d %Creset%s %C(cyan)%aN" --date short --graph --decorate'
    abbr glo 'git-forgit log'
    abbr gm 'git merge'
    abbr gp 'git push'
    abbr gr 'git reset'
    abbr gs 'git status'
    abbr gss 'git-forgit stash_show'
    abbr gsp 'git-forgit stash_push'

    set -gx EDITOR nvim

    # use Linux colors for ls on macOS
    set -gx LSCOLORS "ExGxBxDxCxEgEdxbxgxcxd"

    # fzf
    #set -gx FZF_DEFAULT_COMMAND 'rg --files --hidden --glob "!.git/*"'
    set -gx FZF_DEFAULT_COMMAND 'fd --type file --strip-cwd-prefix --no-ignore --hidden --exclude .git'
    set -gx FZF_CTRL_T_COMMAND  "$FZF_DEFAULT_COMMAND"
    set -gx FZF_DEFAULT_OPTS    "--height=80% --layout=reverse " # do not use --ansi it makes fzf slow
    #set -gx FZF_CTRL_R_OPTS     "--preview "
    # using original fzf fish functions file but renamed to "fzf-history-widget.fish" and with outer function and key bindings removed
    bind \cr fzf-history-widget
    # fzf-file-widget is only available after fzf-history-widget was executed/autoloaded
    bind \ct fzf-file-widget

    # ssh completion with fzf
    function fssh -d "Fuzzy-find ssh host and ssh into it"
        rg --ignore-case '^host [^*]' ~/.ssh/config | cut -d ' ' -f 2- --output-delimiter=\n | sort | uniq -u | fzf | read -l result; and commandline "ssh $result"
        commandline -f execute
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

    function fgb
        set branches "$(git branch --all | grep -v HEAD)"
        set branch $(echo "$branches" | fzf)
        git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
    end

    function fcd
        while true
            set result $(fd --max-depth 1 --type d --hidden | fzf --bind "right:accept" --bind "left:become(echo '..')" --bind "q:abort")
            switch "$result"
                case ""
                    return 0
                case ".."
                    cd ..
                case '*'
                    cd $result
            end
        end
    end

    if test -e ~/.work.fish; source ~/.work.fish; end

    # zoxide
    zoxide init fish | source
    bind \ec 'zi; commandline -f repaint'

    # atuin
    set -gx ATUIN_NOBIND "true"
    atuin init fish | source
    bind \cr _atuin_search

    starship init fish | source
end
