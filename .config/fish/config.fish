if status is-interactive
    set -U fish_greeting ""

    alias ls="lsd"
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

    # set colors for fd
    set -gx LS_COLORS "rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.webp=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:"

    # set color theme for bat
    set -gx BAT_THEME base16

    # fzf
    #set -gx FZF_DEFAULT_COMMAND 'rg --files --hidden --glob "!.git/*"'
    set -gx FZF_DEFAULT_COMMAND 'fd --type file --strip-cwd-prefix --no-ignore --hidden --exclude .git'
    set -gx FZF_CTRL_T_COMMAND  "$FZF_DEFAULT_COMMAND"
    set -gx FZF_DEFAULT_OPTS    "--style=full --prompt='󰁕 ' --pointer='▌' --color=bg+:#444444,gutter:-1,pointer:blue,prompt:green --border --layout=reverse " # do not use --ansi it makes fzf slow
    # using original fzf fish functions file but renamed to "fzf-history-widget.fish" and with outer function and key bindings removed
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

    function mc
        set MC_USER (whoami)
        set MC_PWD_FILE (mktemp -u -t mc-$MC_USER.pwd.XXXXX)
        /usr/bin/mc -P "$MC_PWD_FILE" $argv

        if test -r "$MC_PWD_FILE"
            set MC_PWD (cat "$MC_PWD_FILE")
            if test -n "$MC_PWD" -a "$MC_PWD" != "$PWD" -a -d "$MC_PWD"
                cd "$MC_PWD"
            end
            set -e MC_PWD
        end

        rm -f "$MC_PWD_FILE"
        set -e MC_PWD_FILE
        set -e MC_USER
    end

    if test -e ~/.work.fish; source ~/.work.fish; end

    # zoxide
    zoxide init fish | source
    bind \ec 'zi; commandline -f repaint'

    bind \ex 'br; commandline -f repaint'

    # atuin
    set -gx ATUIN_NOBIND "true"
    atuin init fish | source
    bind \cr _atuin_search

    starship init fish | source
end
