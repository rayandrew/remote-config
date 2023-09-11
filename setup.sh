#!/usr/bin/env bash

CURRENT_DIR="$HOME/.config/remote-config"

ln -sf $CURRENT_DIR/.zshrc $HOME/.zshrc
ln -sf $CURRENT_DIR/.p10k.zsh $HOME/.p10k.zsh
ln -sf $CURRENT_DIR/.tmux.conf $HOME/.tmux.conf
