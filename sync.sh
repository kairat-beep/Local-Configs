#!/bin/bash

# Use current directory as the dotfiles repo
DOTFILES_DIR="$PWD"

# System config locations
NVIM_SYS=~/.config/nvim/init.lua
TMUX_SYS=~/.tmux.conf
GNUPG_SYS=~/.gnupg/gpg-agent.conf

# Repo config locations (relative to current dir)
NVIM_REPO=$DOTFILES_DIR/nvim/init.lua
TMUX_REPO=$DOTFILES_DIR/tmux/.tmux.conf
GNUPG_REPO=$DOTFILES_DIR/gnupg/gpg-agent.conf
# Ensure necessary directories exist
mkdir -p "$(dirname "$NVIM_SYS")"
mkdir -p "$(dirname "$NVIM_REPO")"
mkdir -p "$(dirname "$TMUX_REPO")"
mkdir -p "$(dirname "$GNUPG_REPO")"

# 🧠 Sync modes
sync_pull() {
  echo "⬇️  Pulling from system → $DOTFILES_DIR"
  rsync -av --update "$NVIM_SYS" "$NVIM_REPO"
  rsync -av --update "$TMUX_SYS" "$TMUX_REPO"
  rsync -av --update "$GNUPG_SYS" "$GNUPG_REPO"
  echo "✅ Pull complete"
}

sync_push() {
  echo "⬆️  Pushing from $DOTFILES_DIR → system"
  rsync -av --update "$NVIM_REPO" "$NVIM_SYS"
  rsync -av --update "$TMUX_REPO" "$TMUX_SYS"
  rsync -av --update "$GNUPG_REPO" "$GNUPG_SYS"
  echo "✅ Push complete"
}

# 🚦 Entry point
case "$1" in
  --pull)
    sync_pull
    ;;
  --push)
    sync_push
    ;;
  *)
    echo "Usage: $0 [--pull | --push]"
    echo "  --pull   Sync from system → current directory"
    echo "  --push   Sync from current directory → system"
    exit 1
    ;;
esac

