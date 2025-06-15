# 8BitTitan's personal dotfiles

This repository holds majority of my personal configuration for my MacOS setup. Including but not limited to:

- zsh (shell)
- Homebrew (MacOS package manager)
- Neovim (editor)
- ~~Ghostty (terminal)~~
    - Currently using Wezterm
- Wezterm (terminal)
- Starship (prompt)
- tmux (multiplexer)
- mise (languages management)
- eza (better `ls`)
- bat (better `cat`)
- git

## Quickstart

To quickly get started with this setup, proceed with the following:

Clone the repository into your `$HOME` directory
```bash
git clone https://github.com/8bittitan/dotfiles.git ~/.dotfiles
```

Move into the created directory
```bash
cd ~/.dotfiles
```

Run the install script
```bash
./bin/setup_mac
```

After everything is installed, run GNU Stow to create all needed symlinks
```bash
stow .
```

## Screenshots

Terminal
![Terminal](assets/term.png)

Neovim
![Neovim](assets/vim.png)
