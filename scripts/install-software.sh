#!/bin/bash

# set -ex

if [ $(uname -s) = "Linux" ]; then
    if ! sudo -v &> /dev/null; then
        echo "Failed to execute sudo. Make sure you have sudo privileges."
        exit 1
    fi
fi

if [ -f /etc/debian_version ]; then
    echo "Detect Debian based system, installing packages with apt..."
    sudo apt update
    sudo apt install -y git tmux zsh lf ranger rsync htop bat fzf python3 unzip fd-find lsd wget ripgrep todotxt-cli clang nodejs
    sudo snap install --beta neovim --classic
    curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
    sudo ln -s -f /usr/bin/batcat /usr/bin/bat
    sudo ln -s -f /usr/bin/fdfind /usr/bin/fd
    sudo ln -s -f /usr/bin/python3 /usr/bin/python
    echo "Please install glow and kitty manually if you want"
fi

if [ -f /etc/arch-release ]; then
    echo "Detect Arch based system, installing packages with pacman..."
    sudo pacman -Sy
    sudo pacman -S --needed --noconfirm git tmux zsh lf ranger rsync htop bat python fzf unzip zoxide lsd fd wget ripgrep neovim glow clang nodejs
    echo "Please install todotxt-cli and kitty if you want."
fi

if [ $(uname -s) = "Darwin" ]; then
    echo "Detect macOS, installing packages with homebrew..."
    brew tap zegervdv/zathura
    brew update
    brew install git tmux zsh lf ranger kitty rsync htop bat python fzf unzip zoxide lsd fd wget ripgrep neovim glow zathura todo-txt nodejs
fi

# git submodule init
# git submodule update
git submodule update --init --recursive

BASEDIR=~/.config
CURDIR=$(pwd)
read -p "Do you want to overwrite or backup the configuration file? (o/b): " response

if [ "$response" == "o" ]; then
    echo "Overwriting the configuration file..."
    yes | rm -r $BASEDIR/tmux
    yes | rm -r $BASEDIR/zsh
    yes | rm -r $BASEDIR/lf
    yes | rm -r $BASEDIR/todo
    yes | rm -r $BASEDIR/nvim
    ln -s -f $CURDIR/tmux $BASEDIR/
    ln -s -f $CURDIR/zsh/zsh $BASEDIR/
    ln -s -f $CURDIR/zsh/zshrc ~/.zshrc
    ln -s -f $CURDIR/lf $BASEDIR/
    ln -s -f $CURDIR/todo $BASEDIR/
    ln -s -f $CURDIR/nvim $BASEDIR/
elif [ "$response" == "b" ]; then
    echo "Backup the configuration file..."
    mv $BASEDIR/tmux $BASEDIR/tmux_bak || echo "$BASEDIR/tmux not found. Skip."
    mv $BASEDIR/zsh $BASEDIR/zsh_bak || echo "$BASEDIR/zsh not found. Skip."
    mv ~/.zshrc ~/.zshrc_bak || echo "~/.zshrc not found. Skip."
    mv $BASEDIR/lf $BASEDIR/lf_bak || echo "$BASEDIR/lf not found. Skip."
    mv $BASEDIR/todo $BASEDIR/todo_bak || echo "$BASEDIR/todo not found. Skip."
    mv $BASEDIR/nvim $BASEDIR/nvim_bak || echo "$BASEDIR/nvim not found. Skip."
    ln -s $CURDIR/tmux $BASEDIR/
    ln -s $CURDIR/zsh/zsh $BASEDIR/
    ln -s $CURDIR/zsh/zshrc ~/.zshrc
    ln -s $CURDIR/lf $BASEDIR/
    ln -s $CURDIR/todo $BASEDIR/
    ln -s $CURDIR/nvim $BASEDIR/
else
    echo "Invalid response. Please enter 'o' or 'b'."
    exit 1
fi
