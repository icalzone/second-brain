# AI Developer Tools

A reference for AI-assisted development workflows, including ChatGPT prompt engineering for software engineers and Claude Code usage patterns.

## ChatGPT Prompts for Software Engineers

From `development/raw/30 Best ChatGPT Prompts for Software Engineers/` — a collection of practical prompts organized by task type.

### Code Review & Explanation
```
Review this [language] code for bugs, performance issues, and best practices:
[paste code]
```

```
Explain this code to me like I'm a junior developer. Focus on the key concepts:
[paste code]
```

### Debugging
```
I'm getting this error: [error message]
Here's the relevant code: [code]
What's causing it and how do I fix it?
```

### Architecture & Design
```
I'm building [description of system]. What architecture would you recommend?
Key requirements: [list requirements]
```

```
What are the trade-offs between [Option A] and [Option B] for [use case]?
```

### Documentation
```
Write JSDoc/XML doc comments for this function:
[paste function]
```

```
Generate a README for this project:
[paste key files or describe project]
```

### Test Generation
```
Write unit tests for this function using [Jest/xUnit/etc]:
[paste function]
Cover: happy path, edge cases, error cases.
```

### Refactoring
```
Refactor this code to be more readable and maintainable.
Keep the behavior identical:
[paste code]
```

### Learning
```
What are the top 5 things a developer should know about [technology]?
Assume I know [related technology].
```

---

## Claude Code Cheat Sheet

From `development/raw/Claude Code Cheat Sheet.pdf` — quick reference for using Claude Code effectively.

### Key Workflows

**Context management:**
- Keep your `CLAUDE.md` file updated with project conventions, build commands, and architecture notes
- Use `/clear` to reset context when switching tasks
- Reference files explicitly: "Look at `src/auth/middleware.ts` and..."

**Effective prompting:**
- Be specific about the language, framework, and version
- Provide error messages in full
- Describe the expected behavior vs. actual behavior
- Ask Claude to explain its reasoning when the solution isn't obvious

**File operations:**
- Ask Claude to read files before editing them
- Request diffs or summaries of changes before applying
- Use "only modify X, don't change Y" to limit scope

**Verification:**
- Always run tests after AI-generated changes
- Review diffs before committing
- Ask Claude "what could go wrong with this approach?"

---

## Sources
- `development/raw/30 Best ChatGPT Prompts for Software Engineers/`
- `development/raw/Claude Code Cheat Sheet.pdf`

## Related
- [[testing]] — Use AI tools to generate test cases
- [[javascript]] — Prompt patterns for JS debugging
- [[INDEX]] — Development wiki home
