# dotfiles

## How to use

### MacOS

#### GitHub SSH Key settings

Set SSH key for GitHub.

```bash
# Make directory for SSH keys
mkdir .ssh
cd .ssh

# Generate SSH key
ssh-keygen -t ed25519 -C "<mail adress>" -f ~/.ssh/github_ed25519
```

Set public key to GitHub settings and copy following code to `~/.ssh/config`.

```~/.ssh/config
Host github
  HostName github.com
  User git
  Port 22
  IdentityFile ~/.ssh/github_ed25519
  TCPKeepAlive yes
  IdentitiesOnly yes
```

```bash
# Add new key to identity lists
ssh-add ~/.ssh/github_ed25519

# Connect test to GitHub
ssh -T git@github.com
```

#### Install homebrew

See [Homebrew](https://brew.sh/), and install it with the command which is written in this site.
When 2025/10, The command is following.

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

#### Install mise and Python

Install [mise](https://mise.jdx.dev/).

```bash
brew install mise
```

Install Python3.

```bash
# Install xz for unfreeze .xz file
brew install xz

# Search Python version
mise ls-remote python

# Install Python
mise settings python.compile=1
mise install python@3.<version>
```

#### Install Hack Nerd Font, Alacritty and neovim

Install [Hack Nerd Font](https://www.nerdfonts.com/), [Alacritty](https://alacritty.org/) and [neovim](https://neovim.io/).

```bash
brew install --cask font-hack-nerd-font
brew install --cask alacritty
brew install neovim
```

#### Install git

```bash
brew install git
git config --global user.email "<mail adress>"
git config --global user.name "<username>"
```

#### Install Rust

Install [Rust](https://rust-lang.org/), with rustup.
Why not use mise is rustup is more useful.

```bash
brew install rustup
rustup default stable
```

Install rust-analyzer.

```bash
rustup component add rust-analyzer
```

### Add synbolic link

```bash
ln -s dotfiles/.zshrc ~
ln -s dotfiles/.zprofile ~
ln -s dotfiles/.config ~
```
