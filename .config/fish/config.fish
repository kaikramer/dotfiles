alias vi='nvim'

set -x FZF_DEFAULT_COMMAND 'rg --files --hidden --glob "!.git/*"'

set -g theme_display_git yes
set -g theme_display_git_dirty yes
set -g theme_display_git_untracked no
set -g theme_display_git_ahead_verbose no
set -g theme_display_git_dirty_verbose no
set -g theme_display_git_stashed_verbose no
set -g theme_display_git_master_branch no
set -g theme_git_worktree_support no # buggy
set -g theme_use_abbreviated_branch_name yes
set -g theme_display_vagrant no
set -g theme_display_docker_machine no
set -g theme_display_k8s_context yes
set -g theme_display_hg no
set -g theme_display_virtualenv no
set -g theme_display_ruby no
set -g theme_display_nvm yes
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
set -g theme_color_scheme base16
set -g fish_prompt_pwd_dir_length 1
set -g theme_project_dir_length 1
set -g theme_newline_cursor no
set -g theme_newline_prompt '$ '

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
