# JavaScript

A reference covering JavaScript optimization techniques, common error types, practical fetch patterns, and design patterns for cleaner code.

## JavaScript Optimization

JavaScript files are critical to web performance. Unoptimized JS causes render blocking, slow load times, and poor user experience — all of which hurt SEO rankings.

### Core Problems

| Problem | Impact |
|---|---|
| **Blocking scripts** | Delays page rendering |
| **Large file sizes** | Slow downloads, high bandwidth |
| **Inefficient code** | Excessive loops, redundant calculations |

### Optimization Techniques

**Minification** — Remove whitespace, comments, and unnecessary characters to reduce file size. Tools: Terser, esbuild, webpack.

**Compression** — Use gzip or Brotli compression on the server to reduce transfer size.
- Tools: [JSCompress](https://jscompress.com/), Closure Compiler

**Tree Shaking** — Eliminate unused code at build time (supported by webpack, Rollup, esbuild).

**Code Splitting** — Split large bundles into smaller chunks loaded on demand.
- `import()` dynamic imports in modern JS
- Route-based splitting in React, Vue, Angular

**Lazy Loading** — Defer loading scripts until they're needed.
```html
<script src="analytics.js" defer></script>
<script src="widget.js" async></script>
```

**Caching** — Leverage browser caching with proper cache headers and content hashing filenames.

### Sources
- [A Guide to Optimizing JavaScript Files — SitePoint](https://www.sitepoint.com/optimizing-javascript-files/)

---

## JavaScript Error Types

Every JavaScript error has a type that tells you where to look:

| Error Type | When It Occurs | Example |
|---|---|---|
| **SyntaxError** | Parser phase — mismatched brackets, typos | `console.log('Hello World';` |
| **ReferenceError** | Accessing an undeclared variable | `console.log(undefinedVar)` |
| **TypeError** | Wrong type for an operation | Calling a non-function, accessing `.prop` on null |
| **RangeError** | Value out of allowed range | `new Array(-1)` |
| **URIError** | Malformed URI functions | `decodeURIComponent('%')` |
| **EvalError** | Issues with `eval()` | (rare in modern JS) |

**Debugging Tips:**
- Read the error message and the stack trace — the line number is your first clue
- `TypeError: Cannot read properties of undefined` → check for null/undefined before accessing
- `ReferenceError: x is not defined` → check scope and declaration order

### Sources
- [Understanding the types of JavaScript errors — DEV Community](https://dev.to/sharifmrahat/understanding-the-types-of-javascript-errors-3d8)

---

## JavaScript Fetch Patterns

Modern patterns for making HTTP requests with the Fetch API. See `development/raw/JavaScript Fetch Patterns...` for full code examples.

**Basic fetch:**
```js
const res = await fetch('/api/data');
const json = await res.json();
```

**Error handling:**
```js
const res = await fetch('/api/data');
if (!res.ok) throw new Error(`HTTP ${res.status}`);
const json = await res.json();
```

**POST with JSON:**
```js
const res = await fetch('/api/items', {
  method: 'POST',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify({ name: 'value' }),
});
```

---

## Builder Design Pattern (JavaScript)

The Builder pattern solves the "telescoping constructor" problem — when a class has many optional parameters, a constructor with 8+ arguments is unreadable and error-prone.

**Without Builder:**
```js
class Frog {
  constructor(name, gender, eyes, legs, scent, tongue, heart, weight, height) { ... }
}
// Calling this is unreadable
new Frog('Kermit', 'male', { type: 'googly' }, 4, 'musky', null, null, 0.5, 10)
```

**With Builder:**
```js
class FrogBuilder {
  constructor(name, gender) {
    this.name = name;
    this.gender = gender;
  }
  setEyes(eyes) { this.eyes = eyes; return this; }
  setLegs(legs) { this.legs = legs; return this; }
  setWeight(weight) { this.weight = weight; return this; }
  build() { return this; }
}

const frog = new FrogBuilder('Kermit', 'male')
  .setEyes({ type: 'googly' })
  .setLegs(4)
  .setWeight(0.5)
  .build();
```

**Why use it:**
- Readable, chainable construction
- Optional fields are genuinely optional
- Easy to add validation in `build()`

### Sources
- [4 Dangerous Problems in JavaScript Easily Solved by the Builder Design Pattern — Better Programming](https://medium.com/better-programming/4-dangerous-problems-in-javascript-easily-solved-by-the-builder-design-pattern-7f0eb5b4455c)

---

## Related
- [[testing]] — JavaScript error debugging in context
- [[web-images]] — Image optimization alongside JS optimization
- [[INDEX]] — Development wiki home
