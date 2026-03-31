# Dotfiles

Bare git repo managing config files in `$HOME`.

## Contents

- **Neovim** (`~/.config/nvim/`) — LSP (clangd, lua_ls), Telescope, Treesitter, DAP, lazy.nvim
- **Bash** (`~/.bashrc`, `~/.bash_profile`, `~/.profile`)

## Setup on a new machine

```bash
git clone --bare <repo-url> ~/.dotfiles
alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
dotfiles checkout
dotfiles config status.showUntrackedFiles no
```

If checkout conflicts with existing files, back them up first:

```bash
dotfiles checkout 2>&1 | grep -E "^\s" | xargs -I{} mv {} {}.bak
dotfiles checkout
```

## Usage

```bash
alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

dotfiles add ~/.config/nvim/lua/plugins/new_plugin.lua
dotfiles commit -m "Add new plugin"
dotfiles push
```
