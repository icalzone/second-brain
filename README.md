# Second Brain

A personal, multi-topic knowledge base designed to grow with whatever I'm learning or exploring. Topics live as top-level folders and can be added at any time.

## Topics

| Folder | Topic | Wiki |
|---|---|---|
| [windows/](windows/) | Windows 11 installs & configuration | [windows/wiki/INDEX.md](windows/wiki/INDEX.md) |
| [development/](development/) | Web development, SwiftUI, C#, .NET, Docker, testing, tools | [development/wiki/INDEX.md](development/wiki/INDEX.md) |
| [swiftui/](swiftui/) | SwiftUI & iOS development | [swiftui/wiki/INDEX.md](swiftui/wiki/INDEX.md) |
| [travel/](travel/) | U.S. national park road trips, RV travel, photography parks | [travel/wiki/INDEX.md](travel/wiki/INDEX.md) |
| [photography/](photography/) | Smartphone photography techniques, settings, apps | [photography/wiki/INDEX.md](photography/wiki/INDEX.md) |
| [productivity/](productivity/) | Task management system, Apple Shortcuts automation | [productivity/wiki/INDEX.md](productivity/wiki/INDEX.md) |
| [apple/](apple/) | iPhones, Mac, iOS shortcuts | *(wiki coming soon)* |
| [finance/](finance/) | Personal finance notes and tools | *(wiki coming soon)* |

## How It's Organized

Each topic folder contains:
- **raw/** — Unprocessed source material (scraped pages, notes, pastes). Never modify these files.
- **wiki/** — Organized wiki maintained by AI. Each major concept gets its own `.md` file.
- **outputs/** — Generated reports, answers, briefings, and analyses.

## Wiki Conventions

- Every topic gets its own `.md` file in `wiki/`
- Every wiki file starts with a one-paragraph summary
- Related topics are linked using `[[topic-name]]` format
- Each `wiki/` folder has an `INDEX.md` listing all articles

## Wiki Highlights

### Development
- [[development/wiki/javascript]] — JS optimization, error types, fetch patterns, Builder pattern
- [[development/wiki/docker]] — Docker CLI cheat sheet
- [[development/wiki/optimizely-cms]] — ContentArea, catalog, SQL, Azure Blobs
- [[development/wiki/testing]] — UI testing types, Playwright automation
- [[development/wiki/power-platform]] — Power Automate filter queries, Level Up God Mode

### SwiftUI
- [[swiftui/wiki/viewmodifier]] — The ViewModifier pattern for iOS 26 Liquid Glass UI

### Travel
- [[travel/wiki/utah-national-parks]] — The Mighty Five road trip
- [[travel/wiki/great-smoky-mountains]] — Experiences, waterfalls, and timing
- [[travel/wiki/yellowstone]] — One-day Southern Loop itinerary
- [[travel/wiki/national-park-photography]] — 9 most scenic parks for photography

### Productivity
- [[productivity/wiki/task-system]] — Calm task system (Apple Reminders + Second Brain)
- [[productivity/wiki/apple-shortcuts-recipes]] — Shortcut recipes for capture automation

### Photography
- [[photography/wiki/smartphone-photography]] — Camera setup, settings, composition, apps

### Windows
- [[windows/wiki/developer-setup]] — Full Windows 11 dev environment guide
- [[windows/wiki/work-setup]] — Corporate machine setup checklist

## Adding a New Topic

1. Create `{topic}/raw/`, `{topic}/wiki/`, `{topic}/outputs/`
2. Drop source material into `{topic}/raw/`
3. Add a row to the table above
4. Run the compile prompt: *"Read everything in raw/. Compile a wiki in wiki/ following the rules in CLAUDE.md."*
