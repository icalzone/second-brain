# Windows Developer Setup

A comprehensive guide to setting up a Windows 11 machine for web and software development. The recommended approach centers on WSL2 (Windows Subsystem for Linux), which gives you a full Linux environment running alongside Windows.

## Prerequisites

- Windows 11
- A [GitHub](https://github.com) account

## WSL2 (Windows Subsystem for Linux)

WSL2 is the foundation of a Windows dev environment — it provides a real Linux kernel with full system call compatibility.

**Install WSL2:**
```sh
wsl --install
```
This enables WSL and Virtual Machine Platform, installs the latest Linux kernel, sets WSL2 as default, and installs Ubuntu. A reboot may be required.

**Update Linux packages regularly:**
```sh
sudo apt update && sudo apt upgrade
```

**Map your Linux Drive in File Explorer:**
1. Navigate to `\\wsl$\` in File Explorer
2. Right-click the Ubuntu folder → Map network drive
3. Check "Reconnect at sign-in"

> Store project files on the Linux file system (not Windows) for better performance.

**Restart WSL if it stops working:**
```sh
wsl.exe --shutdown
wsl.exe
```

## Windows Terminal

Install from the Microsoft Store. Configure:
- **Default Profile:** Ubuntu (your WSL distribution)
- **Starting Directory:** `//wsl$/Ubuntu/home/<username>/code`

## Git Configuration

```sh
git config --global user.name "Your Name"
git config --global user.email "you@example.com"
git config --global user.username "yourgithubusername"
```

**GitHub CLI:** Install `gh`, then create a Personal Access Token and store it with Git Credential Manager.

## Zsh + Oh My Zsh

```sh
# Install Zsh
sudo apt install zsh

# Install cURL first
sudo apt install curl

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Useful plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

## Node.js with NVM

```sh
# Install NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash

# Install latest LTS
nvm install --lts

# Switch versions
nvm use 18
```

**NPM essentials:**
```sh
npm install <package>          # install dependency
npm install --save-dev <pkg>   # dev dependency
npm install                    # batch install from package.json
npm uninstall <package>
```

## Visual Studio Code

Install from [code.visualstudio.com](https://code.visualstudio.com/). Key extensions:
- **Remote - WSL** — work inside WSL from VS Code
- Change default shell to WSL/Ubuntu

## Docker

See [[../development/wiki/docker]] for Docker fundamentals. Installation options:
- **Option 1:** Docker Desktop for Windows (GUI + CLI)
- **Option 2:** Install Docker CLI directly inside WSL2

**Test install:**
```sh
docker run hello-world
```

## Python

```sh
# Install pip and venv
sudo apt install python3-pip python3-venv

# Create a virtual environment
python3 -m venv env
source env/bin/activate

# Popular frameworks
pip install flask
pip install django
pip install jupyterlab
```

VS Code extensions: Python, Pylance, Jupyter

## Chrome Extensions Recommended
- Wallabag (save pages for later)
- FreshRSS (RSS reader)

## Sources
- `windows/raw/developer-install.md` — Windows Web Developer Setup Guide (2026)

## Related
- [[work-setup]] — Work machine configuration
- [[INDEX]] — Windows wiki home
