source $HOME/.dotfiles/programs/fish/nix.fish 

set -x PYENV_ROOT $HOME/.pyenv
set -x PATH $PATH $PYENV_ROOT/bin

eval (pyenv init - | source)

set -x PATH $PATH "$HOME/.local/share/bin"

set -x FZF_CTRL_T_COMMAND "fd --type f --ignore-file $HOME/.dotfiles/.gitignore --hidden --exclude .git"

set -x FZF_DEFAULT_OPTS "--height 100% --reverse"
