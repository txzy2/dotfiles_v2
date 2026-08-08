functions -e fish_prompt

alias cls="clear"
alias m="make"

set -x PATH /opt/nvim-linux-x86_64/bin $PATH

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
