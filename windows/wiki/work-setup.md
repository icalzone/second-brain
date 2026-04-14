# Work Machine Setup

A checklist-style reference for setting up a corporate Windows 11 machine with all required software, peripherals, and development tools.

## Microsoft / Productivity Apps

- **Outlook** — corporate email
- **Teams** — communication
- **OneDrive** — cloud storage
- **Edge** — Wallabag + FreshRSS extensions
- **OneNote** + [OneMore add-in](https://onemoreaddin.com/) — enhanced note-taking; open all notebooks

## Logitech Peripherals

| Device | Setup Link |
|---|---|
| MX Master 3S mouse | [Download - MX Master 3S](https://support.logi.com/hc/en-us/articles/5218049509783) |
| MX Keys keyboard | [Getting Started - MX Keys](https://support.logi.com/hc/en-us/articles/360034762774) |
| C920e Webcam | [Download - C920e](https://support.logi.com/hc/en-us/articles/360055450053) |
| All devices | [Logi Options+](https://www.logitech.com/en-us/software/logi-options-plus.html) |

**Jabra headset:** [Jabra Direct](https://www.jabra.com/software-and-services/jabra-direct)

## Development IDEs & Tools

| Tool | Notes |
|---|---|
| Visual Studio Enterprise | [My Visual Studio Subscriptions](https://my.visualstudio.com/) — set up extensions, hypertherm.com + alloy + foundation repos |
| Visual Studio Code | [code.visualstudio.com](https://code.visualstudio.com/) — set up extensions + .NET configuration |
| Docker Desktop | [docker.com/products/docker-desktop](https://www.docker.com/products/docker-desktop/) |
| SQL Server Management Studio (SSMS) | [Download SSMS](https://learn.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms) |
| WSL (Windows Subsystem for Linux) | [Install WSL](https://learn.microsoft.com/en-us/windows/wsl/install) |

## Languages & Runtimes

- **Node.js** — [nodejs.org/download](https://nodejs.org/en/download/)
- **Python** — [python.org/downloads](https://www.python.org/downloads/)
- **.NET** — [dotnet.microsoft.com/download](https://dotnet.microsoft.com/en-us/download/dotnet)

## Terminal & CLI Tools

- **Windows Terminal** — run M365 CLI, Optimizely CLI
  - [Optimizely CMS 12 CLI tools (herlitz.io)](https://www.herlitz.io/2022/05/03/optimizely-cms-12-cli-tools-getting-started/)
  - [Install Optimizely (ASP.NET Core)](https://docs.developers.optimizely.com/content-management-system/docs/installing-optimizely-net-5)
- **Git for Windows** — [git-scm.com/download/win](https://git-scm.com/download/win)
- **GitHub Desktop** — [desktop.github.com](https://github.com/apps/desktop)

## Developer Utilities

| Tool | Purpose |
|---|---|
| [PowerToys](https://learn.microsoft.com/en-us/windows/powertoys/) | Window management, keyboard remapping, utilities |
| [DevToys](https://devtoys.app/) | Swiss army knife for developers (JSON, encoding, etc.) |
| [Notepad++](https://notepad-plus-plus.org/) | Lightweight text/code editor |
| [SourceTree](https://www.sourcetreeapp.com/) | Visual Git client |
| [Charles Proxy](https://www.charlesproxy.com/) | HTTP/HTTPS debugging proxy |
| [FileZilla](https://filezilla-project.org/) | FTP/SFTP client |
| [Screaming Frog](https://www.screamingfrog.co.uk/seo-spider/) | SEO site crawler |

## Browsers

- **Chrome** — [google.com/chrome](https://www.google.com/chrome/browser/desktop/)
- **Firefox** — [mozilla.org/firefox](https://www.mozilla.org/en-US/firefox/)

## Adobe Creative Cloud

- Photoshop, Acrobat, Bridge, Illustrator, Media Encoder
- [creative.adobe.com](https://creative.adobe.com/products/download/)

## Corporate / Remote Access

- **Citrix** — [Citrix Workspace setup (internal)](https://hypertherm.sharepoint.com/)
  - URL: `https://hypertherm.cloud.com/`

## After Everything Is Installed

- Add `hypertherm.com` to `hosts.config`
- Set up network locations
- Configure Markdown support in: OneNote, VS Code, Visual Studio, Edge, Chrome

## Sources
- `windows/raw/work-install.md` — Work machine software checklist

## Related
- [[developer-setup]] — Personal/web developer setup guide
- [[INDEX]] — Windows wiki home
