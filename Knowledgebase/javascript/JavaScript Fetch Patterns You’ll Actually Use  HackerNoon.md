---
created: 2025-05-29T09:23:08 (UTC -04:00)
tags: []
source: https://hackernoon.com/javascript-fetch-patterns-youll-actually-use?source=rss
author: Rowsan
---

# JavaScript Fetch Patterns You’ll Actually Use | HackerNoon

> ## Excerpt
> Fetching should be predictable, reusable, and efficient. In real-world apps, it’s about: avoiding unnecessary requests and handling errors properly

---
## Table of Contents

**Introduction:** Why fetch patterns matter in real-world development

**1\. Basic Fetch Request:** The simplest way to get data from an API

**2\. Fetch with Async/Await:** Writing cleaner, more readable fetch logic

**3\. Error Handling in Fetch:** Avoiding silent failures and debugging pain

**4\. Fetch with Retry Logic:** How to handle flaky network requests

**5\. Fetch with Timeout:** Preventing your app from hanging forever

**6\. Parallel Fetch Requests:** Speeding up your app by fetching in batches

**7\. Sequential Fetch Requests:** When the next request depends on the previous one

**8\. Caching Fetch Responses:** Avoiding unnecessary network calls

**9\. Abortable Fetch with AbortController:** Letting users cancel slow requests

**10\. Reusable Fetch Wrapper Function:** Writing less boilerplate, improving consistency

**Conclusion:** Choosing the right pattern for the right use case

### Introduction

**Why Fetch Patterns Matter in Real-World Development**

Most apps don’t fail because of bad ideas. They fail because of bad execution.

And one of the most overlooked areas of execution? **Data fetching.**

Fetching data isn’t just about hitting an API and getting a response. In real-world apps, it’s about:

→ Avoiding unnecessary requests→ Handling loading states properly→ Caching smartly→ Keeping the UI in sync with the backend→ Dealing with errors in a way that doesn't ruin the user experience

Let’s look at a basic example to see where things start to break:

```js
// naive fetch inside a component import { useEffect, useState } from 'react'; function UsersList() { const [users, setUsers] = useState([]); const [loading, setLoading] = useState(true); useEffect(() => { fetch('https://api.example.com/users') .then(res => res.json()) .then(data => { setUsers(data); setLoading(false); }); }, []); if (loading) return <p>Loading...</p>; return ( <ul> {users.map(user => ( <li key={user.id}>{user.name}</li> ))} </ul> ); }
```

This looks fine at first. But here’s the problem:

→ It always fetches when the component mounts, even if we already have the data.→ If the component unmounts quickly, we might get a memory leak warning.→ There’s no retry logic if the network fails.→ If this fetch is used in 5 places, the same request happens 5 times.

In a hobby project, this might be okay. But in real apps, this leads to:

-   Slow performance
-   Broken UI on bad networks
-   Repeated code and logic
-   High server costs from duplicate requests

That’s why we need better patterns. Not “fancier” ones. Just smarter ones.

Fetching should be predictable, reusable, and efficient. That’s how you build apps that feel fast, reliable, and professional.

### **1\. Basic Fetch Request:** _The simplest way to get data from an API_

You don’t need a framework. You don’t need a library. You don’t even need a complex setup.

If you’ve got a browser and a URL, you’ve got everything you need.

That’s the magic of `fetch`.

It’s built right into the browser, and with just a few lines, you can talk to any public API on the internet.

Here’s how it works:

```javascript
fetch('https://jsonplaceholder.typicode.com/posts/1') .then(response => response.json()) .then(data => { console.log(data); }) .catch(error => { console.error('Error:', error); });
```

Let’s break that down:

-   `fetch(url)` makes a network request.
-   `.then(response => response.json())` turns the response into usable JSON.
-   `.then(data => { ... })` gives you the data to do whatever you want.
-   `.catch(error => { ... })` helps you handle anything that goes wrong.

That’s it. No setup. No dependencies. Just a clean way to pull in data.

Try it in your browser’s Dev Tools. Open the Console and paste that code.

You’ll get a post from a fake blog API.

Here’s what it might look like:

```json
{ "userId": 1, "id": 1, "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit", "body": "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum..." }
```

Now, imagine replacing that URL with your own API. Or a weather service. Or a stock price.

You’re no longer guessing what the API does — you’re seeing the data in real time.

And once you can fetch data, you can build apps.

That’s the foundation.

Don’t overthink it. Don’t skip ahead.

Start simple. Master `fetch`.

Because everything else builds on this.

### 2\. Fetch With Async/Await

**Writing cleaner, more readable fetch logic**

Let’s be honest—callbacks were messy. Promises were better. But `async/await`? That’s where code finally started to read like logic instead of chaos.

Before `async/await`, we wrote things like this:

```js
fetch('https://api.example.com/data') .then(response => response.json()) .then(data => { console.log(data); }) .catch(error => { console.error('Error fetching data:', error); });
```

It works. But it’s noisy. You’re juggling `.then()`, `.catch()`, and nesting all over the place.

Now, compare that to this:

```js
async function fetchData() { try { const response = await fetch('https://api.example.com/data'); if (!response.ok) { throw new Error(`HTTP error! Status: ${response.status}`); } const data = await response.json(); console.log(data); } catch (error) { console.error('Error fetching data:', error); } } fetchData();
```

Same result. Less clutter. More focus.

This is why `async/await` is now the standard in modern JavaScript. It makes your `fetch` logic:

-   Easier to follow
-   Easier to debug
-   Easier to extend

Need to add a loading state? Just insert it at the top. Need to retry on failure? Wrap it in a loop.

The key principle: **Code should read top to bottom. Not zigzag sideways.**

So, next time you write a `fetch` call, ask yourself: “Can I make this easier to read?”

Chances are, `async/await` is your answer.

### 3\. Error Handling in Fetch

**Avoiding silent failures and debugging pain**

Most developers use `fetch` like this:

```js
fetch('/api/data') .then(res => res.json()) .then(data => console.log(data))
```

It works.

Until it doesn’t.

You get a blank screen.

Or a vague error like:`Uncaught (in promise) SyntaxError: Unexpected end of JSON input`

And you're stuck.

The truth is: Fetch doesn’t throw an error for HTTP errors. It only throws when there's a _network_ failure.

So, if the server returns a `404` or `500`, `fetch` treats it as a successful response.

This is where silent bugs creep in. You think everything’s fine. But nothing is working.

Here’s how to handle it the right way:

#### ✅ A Better Pattern

```js
async function getData() { try { const res = await fetch('/api/data'); if (!res.ok) { // Not a network error, but a bad HTTP status throw new Error(`Server error: ${res.status}`); } const data = await res.json(); return data; } catch (err) { console.error('Fetch failed:', err.message); // You can also show a fallback UI or retry logic here } }
```

Let’s break this down.

-   `res.ok` checks for status codes in the range 200–299.
-   We **manually throw** if the status isn't OK.
-   That way, any 404s or 500s don’t go unnoticed.
-   The `catch` block will now handle both network issues _and_ HTTP issues.

This one change saves hours of debugging.

#### 🔍 Bonus: Handling Bad JSON

Sometimes, the server returns invalid JSON. Maybe it’s a 204 No Content. Or maybe the API is down and returns HTML.

If you just write `await res.json()`, your app might crash.

You can fix that, too:

```js
async function getDataSafely() { try { const res = await fetch('/api/data'); if (!res.ok) { throw new Error(`HTTP error: ${res.status}`); } // Try parsing JSON safely let data; try { data = await res.json(); } catch { throw new Error('Invalid JSON response'); } return data; } catch (err) { console.error('Error fetching data:', err.message); } }
```

### Key Takeaway:

Don’t trust fetch blindly. It won’t scream at you when something’s wrong. You have to **tell it what counts as an error.**

Because a bug that fails loudly gets fixed fast. A bug that fails silently? That one lives forever.

## 4\. Fetch with Retry Logic

**How to handle flaky network requests**

You build a feature. You test it. Everything works.

Then it breaks in production. But not always—just sometimes.

That’s the worst kind of bug. The one that hides. The one that _sometimes_ works.

Most of the time, the issue isn’t your code. It’s the network.

Maybe the server timed out. Maybe the user lost internet. Maybe the API just glitched.

But here’s the thing: **You can’t stop the glitch.** You can only respond to it.

And that’s where retry logic comes in.

### What is Retry Logic?

Retry logic means this: “If the request fails, try again after a short delay. ”Don’t crash. Don’t give up. Try again.

But do it smartly.→ Don’t retry forever.→ Wait a bit longer each time.→ Stop after a few tries.

This is called **exponential backoff**. And it’s the simplest way to make flaky APIs more reliable.

### Here’s a simple example in JavaScript:

```js
async function fetchWithRetry(url, options = {}, retries = 3, backoff = 500) { try { const response = await fetch(url, options); if (!response.ok) { throw new Error(`Request failed with status ${response.status}`); } return response; } catch (error) { if (retries > 0) { console.warn(`Retrying... (${3 - retries + 1})`); await new Promise(resolve => setTimeout(resolve, backoff)); return fetchWithRetry(url, options, retries - 1, backoff * 2); } else { throw new Error(`Failed after 3 retries: ${error.message}`); } } }
```

### How it works:

1.  You call `fetchWithRetry()` with a URL.
2.  If it fails, it waits half a second.
3.  Then tries again.
4.  Waits longer each time.
5.  After 3 tries, it gives up.

You don’t need a library. You don’t need fancy wrappers. Just a few lines.

And your app becomes 10x more resilient.

### When should you use this?

When calling APIs, which _sometimes_ fail.→ When users might have slow connections.→ When uptime matters and retries are better than errors.

But don’t retry everything. Some errors (like 400 or 403) should **not** be retried. They won’t succeed on the second try.

### Final Thought

In software, you can’t avoid failure. But you can learn how to fail better.

Retry logic doesn’t fix the API. But it makes your product feel stable. And that’s what users care about.

### 5\. Fetch with Timeout

**Preventing Your App from Hanging Forever**

When you call an API, you expect a response. But what if it never comes?

Maybe the server is down. Maybe the network is flaky. Maybe it’s just slow.

Either way, your app waits. And waits.

Until eventually—nothing happens. No error. No success. Just... stuck.

That’s a bad experience for your users.

Here’s the problem: The native `fetch()` in JavaScript doesn’t have a built-in timeout.

It’ll wait _forever_ unless you tell it otherwise.

So, let’s fix that.

### The Solution: Add a Timeout

Here’s a quick way to make `fetch` abort after a set time:

```js
function fetchWithTimeout(url, options = {}, timeout = 5000) { const controller = new AbortController(); const id = setTimeout(() => controller.abort(), timeout); return fetch(url, { ...options, signal: controller.signal }).finally(() => clearTimeout(id)); }
```

#### Example Usage:

```js
fetchWithTimeout('https://api.example.com/data', {}, 3000) .then(res => { if (!res.ok) throw new Error('Network response was not ok'); return res.json(); }) .then(data => console.log(data)) .catch(err => { if (err.name === 'AbortError') { console.error('Fetch timed out'); } else { console.error('Fetch failed:', err.message); } });
```

### Why This Matters

-   **Timeouts prevent your UI from freezing**
-   **They help you fail fast and recover quickly**
-   **They protect your users from poor network conditions**

Here’s the key takeaway:

> Waiting forever is not an option. Always set a timeout when making API calls.

It’s a small change. But it makes your app more reliable. More predictable. And safer to use.

Your users won’t notice it’s there. But they’ll feel the difference.

That’s how you write defensive code. That’s how you build resilient apps.

### 6\. Parallel Fetch Requests

**Speeding up your app by fetching in batches**

When your app loads, it often needs to get data from multiple endpoints.

You might need:

-   A list of users
-   A list of posts
-   And some settings or preferences

Fetching each one **after the other** creates a bottleneck. The app waits for the first request to finish before starting the next one. That’s wasted time.

Let’s say each request takes 500ms.

Fetching them one-by-one takes:

```
500ms + 500ms + 500ms = 1500ms
```

But what if you fetch them **in parallel**?

They all start at the same time. You only wait for the **slowest** one.

```
max(500ms, 500ms, 500ms) = 500ms
```

That’s a 3× speedup.

### How to do it in JavaScript

Let’s look at two versions.

#### ❌ The slow way (sequential)

```js
const getData = async () => { const users = await fetch('/api/users').then(res => res.json()); const posts = await fetch('/api/posts').then(res => res.json()); const settings = await fetch('/api/settings').then(res => res.json()); return { users, posts, settings }; };
```

Each fetch waits for the previous one. That’s slow.

#### ✅ The fast way (parallel)

```js
const getData = async () => { const [usersRes, postsRes, settingsRes] = await Promise.all([ fetch('/api/users'), fetch('/api/posts'), fetch('/api/settings') ]); const [users, posts, settings] = await Promise.all([ usersRes.json(), postsRes.json(), settingsRes.json() ]); return { users, posts, settings }; };
```

All requests are fired at the same time.

Your app waits just once — and gets everything faster.

### When to Batch Requests

Use parallel fetching when:

-   You need multiple independent pieces of data
-   They’re all required before rendering
-   None of them depends on the others

Avoid it if:

-   One request needs the result of another
-   You need to handle one before triggering the next

### The Takeaway

Parallel fetching is a low-effort way to speed up your frontend.

It’s one of those small changes that make a big difference in perceived performance.

**The faster your data loads, the faster your app feels.**

Are you still fetching data one by one?

It’s time to batch and boost.

### 7\. Sequential Fetch Requests

**When the next request depends on the previous one**

Sometimes, making one API request isn’t enough.

You need to wait for the first response before you can make the second.

Let’s say you’re building a dashboard:

-   First, you fetch the logged-in user’s ID
-   Then, you fetch their profile using that ID
-   Finally, you load their settings

Each step depends on the last one. That’s called **sequential fetching**.

Here’s how it looks in plain JavaScript using `async/await`:

```js
async function loadUserData() { try { // Step 1: Get current user const userRes = await fetch('/api/current-user'); const user = await userRes.json(); // Step 2: Get profile based on user ID const profileRes = await fetch(`/api/users/${user.id}/profile`); const profile = await profileRes.json(); // Step 3: Get settings for this user const settingsRes = await fetch(`/api/users/${user.id}/settings`); const settings = await settingsRes.json(); console.log({ user, profile, settings }); } catch (err) { console.error('Failed to load user data:', err); } }
```

This isn’t about fancy tricks or clever one-liners.

It’s about **clarity**.

Each request depends on the result of the one before it, so running them in sequence is the only safe option.

You could try to run them in parallel with `Promise.all`, but it’ll break if one request depends on the output of another.

This matters in real apps — especially dashboards, onboarding flows, and anything with layered data.

If you ever find yourself stuck wondering why data is undefined or missing...

Stop and ask yourself: **Does this request depend on the last one?**

If yes, keep it sequential.

It’ll be slower than parallel, but it’ll work. And working is step one.

### 8\. Caching Fetch Responses – Avoiding Unnecessary Network Calls

Most apps don’t need to fetch data every time a user visits a page.

Yet, that’s what many developers allow.

Every button click. Every page load. The browser hits the API again—even when the data hasn’t changed.

This isn’t just bad for performance. It’s bad for user experience. Pages flicker. Spinners show up. And users wait longer than they should.

Here’s what smart developers do instead: **They cache fetch responses.**

#### Why Cache?

Because not everything needs to be real-time.

If your data updates every 5 minutes, but you re-fetch it every 5 seconds—you’re just wasting bandwidth.

The goal is simple: **Reduce network calls without serving stale data.**

#### A Simple Strategy That Works

Here’s a small pattern you can use in any frontend app: Store the response in memory, check if it exists, and only call the API if needed.

```js
// utils/apiCache.js const cache = new Map(); export async function cachedFetch(url, ttl = 30000) { const now = Date.now(); // Check if cached data exists and is still valid if (cache.has(url)) { const { data, timestamp } = cache.get(url); if (now - timestamp < ttl) { return data; } } // If not cached or expired, fetch from network const response = await fetch(url); const data = await response.json(); // Store the response in cache with timestamp cache.set(url, { data, timestamp: now }); return data; }
```

Now, use it like this:

```js
// pages/Posts.js import { useEffect, useState } from 'react'; import { cachedFetch } from '../utils/apiCache'; export default function Posts() { const [posts, setPosts] = useState([]); useEffect(() => { cachedFetch('https://jsonplaceholder.typicode.com/posts', 60000) // 1 min TTL .then(setPosts) .catch(console.error); }, []); return ( <div> <h1>Recent Posts</h1> <ul> {posts.map(post => ( <li key={post.id}>{post.title}</li> ))} </ul> </div> ); }
```

#### What You Just Did:

-   Prevented re-fetching if the same URL is requested within 60 seconds
-   Made your app faster for the user
-   Reduced unnecessary load on the backend

#### When to Use This Pattern

✅ When data updates slowly✅ When speed matters more than perfect freshness✅ When you’re calling the same API in multiple places

#### Key Takeaway:

You don’t need a full-blown cache system.

Just a little **in-memory store + timestamps** can go a long way.

Start simple. Watch your app get faster. And stop making your users wait for data they already saw.

### 9\. Abortable Fetch with AbortController

**Letting users cancel slow requests**

Imagine you're filling out a form.

You submit it. The loading spinner appears.

But the response takes forever…So you click away. Or hit the back button. Or try again.

Now the browser is still waiting. Still fetching. Still consuming memory. Still tying up bandwidth.

Worse — if your app tries to update state based on that old response, it can throw errors. Or cause a bad user experience.

This is where `AbortController` comes in.

#### The problem:

Fetch requests keep going unless you tell them to stop.

Even if the user navigates away. Even if they change their mind.

#### The fix:

Use `AbortController` to create a signal that can cancel a fetch request.

It’s like giving your request a walkie-talkie. If you say "abort," it stops right there.

### Here's a Simple Example:

```js
const controller = new AbortController(); const signal = controller.signal; fetch('https://api.example.com/data', { signal }) .then(response => { if (!response.ok) throw new Error('Network response was not ok'); return response.json(); }) .then(data => { console.log('Data received:', data); }) .catch(error => { if (error.name === 'AbortError') { console.log('Fetch aborted by user.'); } else { console.error('Fetch error:', error); } }); // Let’s say the user wants to cancel after 2 seconds setTimeout(() => { controller.abort(); // This will stop the fetch }, 2000);
```

### Why This Matters:

Letting users cancel requests makes your app faster and smarter.

✅ It reduces wasted bandwidth

✅ It avoids memory leaks

✅ It keeps your UI in sync with what users actually want

### Real-world Example:

Imagine a search input that fetches results as users type.

Without `AbortController`, typing fast sends overlapping requests — all of which try to update the UI. With `AbortController`, you cancel the old request before firing a new one.

Here’s how that looks:

```js
let controller; async function handleSearch(query) { // Cancel the previous request if it exists if (controller) controller.abort(); controller = new AbortController(); const signal = controller.signal; try { const res = await fetch(`https://api.example.com/search?q=${query}`, { signal }); const data = await res.json(); console.log('Search results:', data); } catch (err) { if (err.name === 'AbortError') { console.log('Previous search aborted'); } else { console.error('Search failed:', err); } } }
```

Every new keystroke cancels the last request. Only the latest one gets through.

### Key takeaway:

You can’t control how fast a network is. But you _can_ control what happens when it’s slow.

Use `AbortController` to give your users the power to cancel. It’s simple. Efficient. And it makes your app feel more responsive.

## 10\. Reusable Fetch Wrapper Function

**Writing less boilerplate, improving consistency**

Most developers repeat the same `fetch` boilerplate over and over again:

```js
fetch('/api/data') .then(res => { if (!res.ok) throw new Error('Failed to fetch'); return res.json(); }) .then(data => console.log(data)) .catch(err => console.error(err));
```

This works. But it's noisy.

It clutters your logic. And every time you make a request, you’re repeating the same pattern.

You don’t need to.

Instead, write a small reusable wrapper that:

-   Automatically handles errors
-   Parses JSON responses
-   Allows easy config overrides

### Here’s a Simple Reusable Fetch Wrapper:

```js
// fetchWrapper.js export async function fetchWrapper(url, options = {}) { try { const res = await fetch(url, { headers: { 'Content-Type': 'application/json', ...options.headers, }, ...options, }); if (!res.ok) { const error = await res.text(); throw new Error(error || `Request failed with status ${res.status}`); } const contentType = res.headers.get('content-type'); if (contentType && contentType.includes('application/json')) { return await res.json(); } return await res.text(); } catch (err) { // Log, alert, or track error here console.error('Fetch error:', err.message); throw err; } }
```

### And now, using it is clean:

```js
import { fetchWrapper } from './fetchWrapper'; async function loadUserData() { try { const user = await fetchWrapper('/api/user'); console.log(user); } catch (err) { // handle error } }
```

### Why This Matters:

→ It cuts repetition

→ It enforces consistency across your app

→ It handles edge cases once, not every time

In real projects, the cost of inconsistency adds up.

You don't need a library for everything. Sometimes, a few lines like this can save hours across a codebase.

## Conclusion

**Choosing the right pattern for the right use case**

There’s no one-size-fits-all in software development.

Every pattern, every abstraction, and every shortcut solves a specific kind of problem. But it can also introduce new ones if misused.

Take a reusable fetch wrapper. It simplifies code and avoids repetition—but it’s not always needed in a small one-off script.

Take custom hooks in React. They clean up logic—but using them too early can hide complexity before you're ready to manage it.

The key is knowing when to abstract and when to leave things raw.

### Here's a simple principle to remember:

> Don’t reach for patterns to sound smart. Reach for them when your code starts to get messy.

Here’s an example.

**Before: lots of repeated logic**

```js
useEffect(() => { fetch('/api/products') .then(res => res.json()) .then(setProducts) .catch(console.error); }, []);
```

**After: a clean custom hook when it makes sense**

```js
const { data: products, loading, error } = useFetch('/api/products');
```

But don’t build a `useFetch` hook if you only fetch data once in the whole app.

Patterns are tools, not trophies.

### The best developers don’t use every pattern.

They use the right ones, at the right time, in the right places.

And that’s what separates clean code from clever code.
