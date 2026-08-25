if status is-interactive
    neofetch
end

function fish_prompt
    set -l last_status $status

    # пользователь@хост
    set_color brcyan
    echo -n (whoami)
    set_color normal
    echo -n '@'
    set_color brcyan
    echo -n (hostname -s)
    set_color normal
    echo -n ' '

    # текущая директория
    set_color bryellow
    echo -n (prompt_pwd)
    set_color normal

    # git-ветка, если есть
    if git rev-parse --is-inside-work-tree >/dev/null 2>&1
        set -l branch (git symbolic-ref --short HEAD 2>/dev/null; or git rev-parse --short HEAD 2>/dev/null)
        set_color brgreen
        echo -n " ($branch)"
        set_color normal
    end

    # индикатор ошибки последней команды
    if test $last_status -ne 0
        set_color brred
    else
        set_color brblack
    end
    echo -n ' > '
    set_color normal
end

# Настройка bobthefish
set -g theme_display_user yes
set -g theme_display_hostname yes
set -g theme_display_date yes
set -g theme_display_cmd_duration yes
set -g theme_powerline_fonts yes
set -g theme_display_git yes
set -g theme_display_git_untracked yes

# ===== КРАСИВЫЕ ЦВЕТА =====
set fish_color_normal brwhite
set fish_color_command brcyan
set fish_color_param bryellow
set fish_color_redirection brred
set fish_color_comment brblack
set fish_color_error brred
set fish_color_escape brgreen
set fish_color_selection white --bold --background=brblack


alias cls="clear"
alias m="make"

alias dc="docker compose"
alias d="docker"

set -x PATH /opt/nvim-linux-x86_64/bin $PATH

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# Go paths
set -x GOPATH $HOME/go
set -x GOBIN $GOPATH/bin

# Add Go to PATH
set -x PATH /usr/local/go/bin $PATH
set -x PATH $GOBIN $PATH

# Optional: Use Go modules by default
set -x GO111MODULE on
