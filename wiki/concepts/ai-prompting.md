---
type: concept
domains: [work, personal]
status: evolving
source-confidence: medium
updated: 2026-05-14
---

# AI Prompting

Prompt patterns and templates for working with AI language models across different domains.

## Weather Summary Prompts

### General Daily Summary
> "Acting as a friendly meteorologist, summarize the following weather data into a 3-sentence daily update. Focus on the most important changes (e.g., rain, temperature drops) and include a 'tip for the day' regarding clothing or activities: [Insert raw data here]"

### 5-Day Outlook (JSON input)
> "Review this JSON data for the next 5 days. Create a concise, conversational weather summary for each day, focusing on highs, lows, and precipitation. Format it as a list: [Insert JSON data]"

### Outdoor Activity Focus
> "Based on the following forecast, provide a quick summary for someone planning outdoor activities. Highlight the best time of day for being outside and warn of any hazards like high winds or thunderstorms: [Insert weather data]"

### Best Practices
- Specify tone: `friendly`, `professional`, `concise`, `dramatic`
- Define output length: word count or sentence count (e.g., "< 160 characters" for SMS)
- Always include key data points: temp (high/low), precipitation %, wind speed, humidity
- Specify output format: bullets, paragraph, JSON

→ Source: [weather-prompts](/raw/weather-prompts.md)

---

## Software Engineering — SDLC Prompts

Prompts organized by development lifecycle stage. Provide prior-stage context when generating code.

| Stage | Sample Prompt Directions |
|-------|------------------------|
| **Planning** | Risk identification, timelines + budgets, tool/technology selection |
| **Analysis** | Functional + non-functional requirements, cost-benefit, risk prioritization |
| **Design** | Data models, design patterns, UI/UX direction, responsive design |
| **Development** | Code generation, optimization, language translation (e.g., Java → Python) |
| **Testing** | Testing strategies, test case generation |
| **Documentation** | Docs, changelogs, README generation |

**Tip:** The more context you provide from earlier stages, the more useful the output in later stages. Paste in requirements or design docs when asking for code.

→ Source: [30 Best ChatGPT Prompts for Software Engineers](/raw/30%20Best%20ChatGPT%20Prompts%20for%20Software%20Engineers/30%20Best%20ChatGPT%20Prompts%20for%20Software%20Engineers.md)

---

## Web Design Prompts

25 prompts organized by design challenge:

| Category | Focus |
|----------|-------|
| **Concept development** | Layout variations, design directions, landing page ideas for specific audiences |
| **Visual & UI design** | Color palettes, typography hierarchies, accessibility-first UI decisions |
| **UX & accessibility** | Navigation clarity, WCAG compliance, user journey critique |
| **Client communication** | Presenting designs, handling feedback, justifying decisions |
| **Strategy** | Positioning, differentiation, long-term design system planning |

**Key tip:** Prompts work best when you include audience, industry, and constraints. "Make me a design" produces worse results than "Generate five homepage layout variations for a B2B SaaS startup that needs to look trustworthy but still innovative, with reasoning for each direction."

→ Source: [25 Useful ChatGPT Prompts for Web Designers](/raw/30%20Best%20ChatGPT%20Prompts%20for%20Software%20Engineers/25UsefulChatGPTPromptsforWebDesigners.md)
