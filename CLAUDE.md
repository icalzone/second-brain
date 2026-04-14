# Second Brain — Knowledge Base Schema

## What This Is
A personal, multi-topic knowledge base designed to grow with whatever you're learning or exploring. Topics live as top-level folders and can be added at any time.

## Current Topics
| Folder | Topic |
|---|---|
| windows/ | Windows 11 installs & configuration |
| development/ | swiftui, ios development, web development, HTML, CSS, JS, frameworks, C#, .NET, docker |
| travel/ | Travel tips, destinations, logistics |
| photography/ | Photography techniques, gear, editing |
| apple/ | iphones, mac, ios shortcuts |
| productivity/ | tools and notes for productivity workflows |
| finance/ | notes and tools for personal finance |

## Adding a New Topic
1. Create a new folder: `{topic-slug}/raw/`, `{topic-slug}/wiki/`, `{topic-slug}/outputs/`
2. Add a one-line entry to the table above
3. Start dropping sources into `{topic-slug}/raw/`

## How Each Topic Is Organized
- **raw/** — Unprocessed source material (scraped pages, notes, pastes). Never modify these files.
- **wiki/** — Organized wiki maintained entirely by AI. Each major concept gets its own `.md` file.
- **outputs/** — Generated reports, answers, briefings, and analyses.

## Wiki Rules (applies to every topic)
- Every topic gets its own `.md` file in `wiki/`
- Every wiki file starts with a one-paragraph summary
- Link related topics using `[[topic-name]]` format
- Maintain an `INDEX.md` in each `wiki/` folder listing every article with a one-line description
- When new raw sources are added, update the relevant wiki articles
- Create or maintain a root-level README.md file to act as an index for the github repo.
- Organize and link all topic INDEX.md files to the README.md

## My Interests
- Development
- Travel
- Photography
- Windows
- Apple
- Productivity
- Finance
