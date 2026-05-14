---
type: system
status: stable
source-confidence: high
updated: 2026-05-13
---

# Windows Developer Environment

A comprehensive setup guide for a Windows web development environment (2026). Built around WSL 2 as the Linux foundation, plus shell tooling, language runtimes, and editors.

## Core Stack

| Layer | Tool |
|-------|------|
| OS / Linux | Windows 11 + WSL 2 (Ubuntu) |
| Shell | Zsh + OhMyZsh |
| Terminal | Windows Terminal |
| Version Control | Git + GitHub CLI |
| Node runtime | Node.js via NVM |
| Python runtime | Python (pip, venv) |
| Ruby runtime | Ruby + Rails |
| Editor | Visual Studio Code (Remote Extension) |
| Containers | Docker Desktop |

## Setup Sequence

1. Install WSL 2 — `wsl --install` (defaults to Ubuntu; reboot may be required)
2. Create Linux user and update packages — `sudo apt update && sudo apt upgrade`
3. Install Windows Terminal; set WSL/Ubuntu as default profile and starting directory
4. Configure Git (name, email, username) and GitHub CLI with a Personal Access Token
5. Install Zsh and OhMyZsh with `zsh-autosuggestions` and `zsh-syntax-highlighting`
6. Install NVM → Node.js; use NPM for package management
7. Install VS Code with the Remote Extension; configure language-specific extensions
8. Install Docker Desktop
9. Install Python and/or Ruby as project needs arise

## Key Details

### WSL
- Use `\\wsl$\` in File Explorer to map the Ubuntu drive as a network location
- Store project files on the Linux filesystem (not `/mnt/c/…`) for speed and stability
- Restart WSL if needed: `wsl.exe --shutdown` then `wsl.exe`

### GitHub CLI Auth
- Auth uses a Personal Access Token stored via Git Credential Manager
- `gh auth login` walks through the flow

### NVM / Node
- NVM manages multiple Node versions side-by-side
- `npm init` → `package.json` → `npm install` workflow standard

### VS Code
- Remote Extension lets VS Code edit files on the Linux filesystem directly
- Includes Vets Who Code Extension Pack and theme
- Change default shell to Zsh after WSL setup

## Source

Raw file: [developer-install.md](/raw/developer-install.md)
