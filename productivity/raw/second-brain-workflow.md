Starter Prompts
1. Scrape a Web Source (Use Anytime)
Scrape [URL] into raw/. Use agent-browser to open the page, extract the main content, and save it as a markdown file in raw/ with a descriptive filename.

2. Compile Your Wiki (Run This First)
Read everything in raw/. Then compile a wiki in wiki/ following the rules in CLAUDE.md. Create an README.md first, then create one .md file per major topic. Link related topics. Summarize every source.

3. Ask Questions Against Your Wiki
Based on everything in wiki/, what are the three biggest gaps in my understanding of [topic]?

Compare what source A says about [concept] vs what source B says. Where do they disagree?

Write me a 500-word briefing on [topic] using only what's in this knowledge base.

Save answers into outputs/ or update wiki articles directly — this is the compounding loop that makes the system smarter.

4. Monthly Health Check
Review the entire wiki/ directory. Flag any contradictions between articles. Find topics mentioned but never explained. List any claims that aren't backed by a source in raw/. Suggest 3 new articles that would fill gaps.

Next Steps
Drop raw sources into any topic's raw/ — or say "scrape [URL] into raw/" and I'll handle it.
Once raw/ has sources, run the compile prompt to build your wiki.
Ask questions against your wiki — answers feed back in and make it smarter.
To add a new topic (e.g. rust/): create the folder + update CLAUDE.md.



Install it now:
Get the LLM Knowledge Builder
​
That drops four commands into your AI agent (Claude Code, Cursor, Codex - whichever you use):

/second-brain — one-time setup wizard
/second-brain-ingest — drop raw sources in, AI builds your wiki
/second-brain-query — ask questions across everything you've fed it
/second-brain-lint — health check the knowledge base
​
Here's how to get your first win in the next 10 minutes:

​Run /second-brain — it walks you through naming and setup
Drop one document into your raw/ folder (an article, a note, anything)
Run /second-brain-ingest — watch it become a structured wiki page
​

That's it. Your AI now has memory it didn't have an hour ago.