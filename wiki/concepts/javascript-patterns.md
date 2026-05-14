---
type: concept
domains: [work]
status: evolving
source-confidence: high
updated: 2026-05-14
---

# JavaScript Patterns

Code patterns, best practices, and reference guides for JavaScript development.

## Design Patterns

### Builder Pattern

Solves the problem of constructors with many optional parameters. Setters return `this` to support fluent chaining.

```js
class FrogBuilder {
    constructor(name, gender) {
        this.name = name;
        this.gender = gender;
    }
    setEyes(eyes)     { this.eyes = eyes; return this; }
    setLegs(legs)     { this.legs = legs; return this; }
    setScent(scent)   { this.scent = scent; return this; }
    setTongue(tongue) { this.tongue = tongue; return this; }
    build() { return this; }
}

const frog = new FrogBuilder('Kermit', 'male')
    .setEyes(2)
    .setLegs(4)
    .build();
```

**Benefits:** readable construction, optional parameters handled cleanly, easy per-setter validation.

→ Source: [patterns-in-action](/raw/patterns-in-action.md)

---

## Fetch Patterns

Common patterns for `fetch()` in real-world applications.

→ Source: [JavaScript Fetch Patterns You'll Actually Use — HackerNoon](/raw/JavaScript%20Fetch%20Patterns%20You%27ll%20Actually%20Use%20%20HackerNoon.md)

---

## Error Types

| Error Type | Cause |
|------------|-------|
| **SyntaxError** | Parsing failure — missing parentheses, mismatched braces, typos in keywords |
| **ReferenceError** | Accessing a variable that hasn't been declared, or accessing a property on `null`/`undefined` |
| **TypeError** | Operation on the wrong type (e.g., calling a non-function, accessing property of `null`) |
| **RangeError** | Value outside an allowable range (e.g., invalid array length) |
| **URIError** | Malformed URI passed to `encodeURI()` or `decodeURI()` |
| **EvalError** | Issues with `eval()` usage |

Errors are detected during parsing (SyntaxError) or at runtime (all others). Each error type points to a different root cause, which narrows the debugging search.

→ Source: [Understanding the types of JavaScript errors — DEV Community](/raw/Understanding%20the%20types%20of%20JavaScript%20errors%20-%20DEV%20Community.md)

---

## Performance Optimization

### Key Issues
- **Render blocking** — scripts block page rendering unless deferred (`defer`) or loaded asynchronously (`async`)
- **Large file size** — large bundles delay download; use code splitting and tree shaking
- **Code inefficiencies** — excessive loops, redundant calculations, inefficient algorithms

### Techniques
- **Minification** — remove whitespace, comments, and unnecessary characters. Tools: Terser, UglifyJS, esbuild
- **Code splitting** — load only what's needed for the current page
- **Tree shaking** — eliminate unused exports (ES modules + bundlers like Rollup/Webpack)
- **Defer/async** — prevent render blocking for non-critical scripts

### Impact on SEO & UX
- Page load speed is a Google ranking factor
- Slow-loading pages → higher bounce rates
- Faster scripts → smoother animations and form interactions

→ Source: [A Guide to Optimizing JavaScript Files — SitePoint](/raw/A%20Guide%20to%20Optimizing%20JavaScript%20Files%20%E2%80%94%20SitePoint.md)

---

## Form Validation (Progressive Enhancement)

A 4-part series on building robust form validation without relying entirely on JavaScript.

**The core idea:** use the browser's native constraint validation API as the foundation, then layer in JavaScript enhancements.

**Part 1 — HTML & CSS**
- Use semantic `input` types (`type="email"`, `type="number"`, etc.) to activate built-in validation
- Use CSS pseudo-classes (`:valid`, `:invalid`, `:user-valid`) for visual feedback without JS
- Built-in constraint validation has been available in browsers for over a decade

**Part 2 — Layering JavaScript**
- Add the Constraint Validation API for custom error messages and programmatic control
- `input.checkValidity()`, `input.setCustomValidity()`, `input.validationMessage`

**Part 3 — Checkbox Groups**
- Native validation doesn't cover checkbox groups (require at least one checked)
- Add JS to validate the group as a whole on submit

**Part 4 — Custom Validation Messages**
- Override browser default error messages with user-friendly, brand-consistent copy

→ Sources: [Progressively Enhanced Form Validation, Part 1](/raw/validation/Progressively%20Enhanced%20Form%20Validation%2C%20Part%201.md) · [Part 2](/raw/validation/Progressively%20Enhanced%20Form%20Validation%2C%20Part%202.md) · [Part 3](/raw/validation/Progressively%20Enhanced%20Form%20Validation%2C%20Part%203.md) · [Part 4](/raw/validation/Progressively%20Enhanced%20Form%20Validation%2C%20Part%204.md)
