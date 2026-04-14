# Note Management

A practical collection of tools and references for maintaining a personal knowledge base: version control with Git and SSH, Markdown authoring, README templates, and shell scripts for routine note-taking workflows.

## SSH Cloning Private GitHub Repos

### Prerequisites
- GitHub account
- VSCode installed
- Git Bash installed (for Windows)

### Generate SSH Key Pair
```bash
# Creates a new SSH key pair (private and public key)
ssh-keygen -t ed25519 -C "your_email@example.com"
# Default location: ~/.ssh/id_ed25519 (private) and ~/.ssh/id_ed25519.pub (public)
```

### Add Public Key to GitHub
1. Copy the public key: `cat ~/.ssh/id_ed25519.pub`
2. GitHub → Settings → SSH and GPG Keys → New SSH Key
3. Paste the key and save

### Clone the Repo
```bash
# SSH clone syntax (use instead of HTTPS)
git clone git@github.com:username/private-repo.git

# VS Code: open cloned folder
code private-repo/
```

### Key Points
- The **private key** stays on your machine — never share it
- The **public key** is uploaded to GitHub — this is what authenticates you
- SSH avoids password prompts on every push/pull
- Test the connection: `ssh -T git@github.com`

---

## Markdown Syntax Quick Reference

### Basic Syntax

| Element | Syntax |
|---|---|
| Heading 1 | `# Heading 1` |
| Heading 2 | `## Heading 2` |
| Heading 3 | `### Heading 3` |
| Bold | `**bold text**` |
| Italic | `*italicized text*` |
| Bold + Italic | `***bold and italic***` |
| Blockquote | `> blockquote` |
| Ordered List | `1. item` |
| Unordered List | `- item` |
| Code | `` `code` `` |
| Horizontal Rule | `---` |
| Link | `[text](https://url.com)` |
| Image | `![alt text](image.jpg)` |

### Extended Syntax

| Element | Syntax |
|---|---|
| Table | `\| col \| col \|` then `\| --- \| --- \|` |
| Fenced Code Block | ` ```language ` ... ` ``` ` |
| Footnote | `text[^1]` then `[^1]: footnote` |
| Strikethrough | `~~text~~` |
| Task List | `- [x] done` / `- [ ] todo` |
| Highlight | `==highlight==` (not always supported) |
| Subscript | `H~2~O` |
| Superscript | `X^2^` |

---

## GitHub README Template

A standard structure for any GitHub repository README:

```markdown
# Project Title

One paragraph describing what this is and why it matters.

## Getting Started

Brief instructions for running the project locally.

### Prerequisites

- Dependency 1 (version or link)
- Dependency 2

### Installing

```bash
npm install
npm start
```

## Running the Tests

```bash
npm test
```

## Deployment

Notes on how to deploy to production.

## Built With

- [Framework](https://link) — Purpose
- [Library](https://link) — Purpose

## Contributing

1. Fork the repo
2. Create a feature branch (`git checkout -b feature/my-feature`)
3. Commit your changes (`git commit -m 'Add feature'`)
4. Push to the branch (`git push origin feature/my-feature`)
5. Open a Pull Request

## Versioning

Using [SemVer](https://semver.org). See [tags](https://github.com/user/repo/tags).

## Authors

- **Your Name** — [GitHub](https://github.com/username)

## License

Licensed under the MIT License.
```

---

## Bash Scripts

### Create a Dated Note: `createnotes.sh`

Creates a new markdown file named with today's date (`DD_MM_YYYY.md`) in the current directory:

```bash
#!/bin/bash
date_str=$(date +"%d_%m_%Y")
filename="${date_str}.md"
touch "$filename"
echo "# Notes for ${date_str}" > "$filename"
echo "Created: $filename"
```

Usage:
```bash
bash createnotes.sh
# Creates: 15_07_2025.md
```

### Stage, Commit, and Push All Changes: `gitall.sh`

A simple wrapper around the three most common Git commands. Commits everything and pushes to origin:

```bash
#!/bin/bash
git add --all
git commit -m "$1"
git push
```

Usage:
```bash
bash gitall.sh "Add notes for July 15"
# Equivalent to:
# git add --all
# git commit -m "Add notes for July 15"
# git push
```

---

## Sources
- `productivity/raw/note-management/github-repo-ssh-clone.md`
- `productivity/raw/note-management/markdown-cheat-sheet.md`
- `productivity/raw/note-management/readme-template.md`
- `productivity/raw/note-management/createnotes.sh`
- `productivity/raw/note-management/gitall.sh`

## Related
- [second-brain-workflow](second-brain-workflow.md) — How the Second Brain wiki system works
- [README](README.md) — Productivity wiki home
- [development wiki](../../development/wiki/README.md) — Git, Docker, JavaScript, and more
