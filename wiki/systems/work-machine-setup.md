---
type: system
domains: [work]
status: evolving
source-confidence: medium
updated: 2026-05-13
---

# Work Machine Setup

Checklist of software, tools, and peripherals for a Windows work computer. Context signals suggest a .NET/CMS development role at Hypertherm (an industrial technology company).

## Communication & Productivity

- **Outlook** — email
- **Teams** — messaging and meetings
- **OneDrive** — cloud storage
- **Edge** — primary browser
  - Extensions: Wallabag, FreshRSS
- **OneNote** + [OneMore add-in](https://onemoreaddin.com/)

## Hardware & Peripherals

| Device | Software |
|--------|----------|
| Logitech MX Master 3S (mouse) | [Logi Options+](https://www.logitech.com/en-us/software/logi-options-plus.html) |
| Logitech MX Keys (keyboard) | Logi Options+ |
| Logi Webcam C920e | Logi Options+ |
| Jabra headset | [Jabra Direct](https://www.jabra.com/software-and-services/jabra-direct) |

## Development Environment

### IDEs & Editors

- **Visual Studio Enterprise** — [VS Subscriptions Portal](https://my.visualstudio.com/)
  - Extensions configured separately
  - Repositories to set up: hypertherm.com, foundation (example), alloy
- **Visual Studio Code** — [code.visualstudio.com](https://code.visualstudio.com/)
  - Extensions configured separately
  - .NET development setup; [download .NET](https://dotnet.microsoft.com/en-us/download/dotnet)
  - hypertherm.com repo configured for development

### Infrastructure

- **Docker Desktop** — [docker.com](https://www.docker.com/products/docker-desktop/)
- **SQL Server Management Studio (SSMS)** — [Microsoft Learn](https://learn.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms)
- **WSL** — [Install WSL](https://learn.microsoft.com/en-us/windows/wsl/install)
- **Node.js** — [nodejs.org](https://nodejs.org/en/download/)
- **Python** — [python.org](https://www.python.org/downloads/)

### Version Control

- **Git for Windows** — [git-scm.com](https://git-scm.com/download/win)
- **GitHub Desktop** — [github.com/apps/desktop](https://github.com/apps/desktop)

## CLI / Terminal Tools

- **Windows Terminal**
  - M365 command line
  - Optimizely CLI — for [Optimizely CMS 12](https://docs.developers.optimizely.com/content-management-system/docs/installing-optimizely-net-5)

## Access & Networking

- **Citrix Workspace** — `hypertherm.cloud.com` ([How-to guide](https://hypertherm.sharepoint.com/:w:/r/sites/ITSupport/_layouts/15/Doc.aspx?sourcedoc=%7BF31F28EC-1A61-49CA-B745-D1DD118FD309%7D&file=How%20to%20use%20Citrix%20Workspace.docx&action=default&mobileredirect=true&DefaultItemOpen=1))
- Network locations configured
- `hypertherm.com` added to `hosts.config`

## Developer Utilities

- **PowerToys** — [Microsoft Learn](https://learn.microsoft.com/en-us/windows/powertoys/)
- **DevToys** — [devtoys.app](https://devtoys.app/) (may replace Hosts File Editor)
- **Notepad++** — [notepad-plus-plus.org](https://notepad-plus-plus.org/)
- **Charles Proxy** — HTTP/HTTPS debugging proxy ([charlesproxy.com](https://www.charlesproxy.com/))
- **Screaming Frog SEO Spider** — site crawler ([screamingfrog.co.uk](https://www.screamingfrog.co.uk/seo-spider/))
- **Xenu** — link checker ([home.snafu.de/tilman/xenulink.html](http://home.snafu.de/tilman/xenulink.html))
- **SourceTree** — Git GUI ([sourcetreeapp.com](https://www.sourcetreeapp.com/))
- **Filezilla** — FTP client ([filezilla-project.org](https://filezilla-project.org/))

## Browsers

- **Chrome** — [google.com/chrome](https://www.google.com/chrome/browser/desktop/)
- **Firefox** — [mozilla.org](https://www.mozilla.org/en-US/firefox/)

## Design & Media

- **Adobe Creative Cloud** — [creative.adobe.com](https://creative.adobe.com/products/download/)
  - Apps: Photoshop, Acrobat, Bridge, Illustrator, Media Encoder

## Source

Raw file: [work-install.md](/raw/work-install.md)
