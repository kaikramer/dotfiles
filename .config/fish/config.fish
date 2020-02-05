alias vi='nvim'

set -x FZF_DEFAULT_COMMAND 'rg --files --hidden --glob "!.git/*"'

set -g theme_display_git yes
set -g theme_display_git_dirty yes
set -g theme_display_git_untracked no
set -g theme_display_git_ahead_verbose yes
set -g theme_display_git_dirty_verbose no
set -g theme_display_git_stashed_verbose yes
set -g theme_display_git_master_branch yes
set -g theme_git_worktree_support no # buggy
set -g theme_use_abbreviated_branch_name yes
set -g theme_display_vagrant no
set -g theme_display_docker_machine no
set -g theme_display_k8s_context no
set -g theme_display_hg no
set -g theme_display_virtualenv no
set -g theme_display_ruby no
set -g theme_display_nvm no
set -g theme_display_user ssh
set -g theme_display_hostname ssh
set -g theme_display_vi no
set -g theme_display_date yes
set -g theme_display_cmd_duration yes
set -g theme_title_display_process yes
set -g theme_title_display_path no
set -g theme_title_display_user yes
set -g theme_title_use_abbreviated_path no
set -g theme_date_format "+%a %H:%M"
set -g theme_avoid_ambiguous_glyphs yes
set -g theme_powerline_fonts no
set -g theme_nerd_fonts yes
set -g theme_show_exit_status yes
set -g theme_display_jobs_verbose yes
set -g default_user kk
#set -g theme_color_scheme base16
set -g fish_prompt_pwd_dir_length 1
set -g theme_project_dir_length 1
set -g theme_newline_cursor no
set -g theme_newline_prompt '$ '

function bobthefish_colors -S -d 'User defined colors'
    set -x color_initial_segment_exit     383838 red
    set -x color_initial_segment_su       383838 green
    set -x color_initial_segment_jobs     383838 blue

    set -x color_path                     383838 white
    set -x color_path_basename            383838 white
    set -x color_path_nowrite             383838 magenta
    set -x color_path_nowrite_basename    383838 magenta

    set -x color_repo                     383838 green
    set -x color_repo_work_tree           383838 green --bold
    set -x color_repo_dirty               383838 green
    set -x color_repo_staged              383838 yellow

    set -x color_vi_mode_default          383838 brblue
    set -x color_vi_mode_insert           383838 brgreen
    set -x color_vi_mode_visual           383838 bryellow

    set -x color_vagrant                  383838 brcyan
    set -x color_k8s                      383838 magenta
    set -x color_username                 383838 brgrey
    set -x color_hostname                 383838 brgrey
    set -x color_rvm                      383838 brmagenta
    set -x color_nvm                      383838 brgreen
    set -x color_virtualfish              383838 brblue
    set -x color_virtualgo                383838 brblue
    set -x color_desk                     383838 brblue
end

set fish_color_command green
set fish_color_param white

# SSH: set tmux pane title to hostname
function ssh
  set ps_res (ps -p (ps -p %self -o ppid= | xargs) -o comm=)
  if string match -q "tmux*" "$ps_res"
    tmux rename-window (echo $argv | cut -d . -f 1)
    command ssh "$argv"
    tmux set-window-option automatic-rename "on" 1>/dev/null
  else
    command ssh "$argv"
  end
end

# workaround for https://github.com/fish-shell/fish-shell/issues/1569
function x86
    echo '(x86)'
end
function X86
    echo '(X86)'
end

set -U fish_user_paths ~/.npm-global/bin $fish_user_paths
set -U fish_user_paths ~/.cargo/bin $fish_user_paths

if test -e .config/fish/proxy.sh
    source .config/fish/proxy.sh
end
