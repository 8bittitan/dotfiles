# 8BitTitan's personal dotfiles

This repository holds majority of my personal configuration for my MacOS setup. Including but not limited to:

- zsh (shell)
- Package manager
    - [mise](https://mise.jdx.dev/) - packages/tools/languages
    - [Homebrew](https://brew.sh) (minimal)
- [Neovim](https://neovim.io/)
- Terminal
    - [Wezterm](https://wezterm.org/)
    - [Rex](https://www.superlogical.com/rex/docs/installation) - Currently trialing
- [Starship](https://starship.rs/) (prompt)
- [tmux](https://github.com/tmux/tmux) (multiplexer)
- [eza](https://eza.rocks/) (better `ls`)
- [bat](https://github.com/sharkdp/bat) (better `cat`)
- [yaak](https://yaak.app/) (API Client)
- [OpenCode](https://opencode.ai/)
- (most other tools are listed in [mise config](./.config/mise/config.toml))

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

## Screenshots

Terminal
![Terminal](assets/term.png)

Neovim
![Neovim](assets/vim.png)
