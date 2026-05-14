---
type: concept
domains: [work]
status: evolving
source-confidence: high
updated: 2026-05-14
---

# Playwright Testing

Best practices for Playwright end-to-end test automation.

## Core Practices

### 1. Use Fixtures for Setup and Teardown

Set up consistent state before each test using `beforeEach`. Avoids repeating navigation and setup logic.

```ts
import { test, expect } from '@playwright/test';

test.beforeEach(async ({ page }) => {
    await page.goto('https://example.com');
});

test('should have a title', async ({ page }) => {
    await expect(page).toHaveTitle(/Example Domain/);
});
```

### 2. Use `data-testid` for Stable Locators

Avoid class names and generated IDs — they change. Add `data-testid` attributes to elements under test.

```html
<button data-testid="submit-button">Submit</button>
```

```ts
test('click the submit button', async ({ page }) => {
    await page.click('[data-testid="submit-button"]');
    await expect(page.locator('[data-testid="success-message"]')).toBeVisible();
});
```

### 3. Always Assert Expected States

Never rely on implicit success. Validate that the UI is in the expected state after each action.

```ts
const button = page.locator('[data-testid="submit-button"]');
await expect(button).toBeEnabled();
await expect(page.locator('[data-testid="result"]')).toContainText('Success');
```

### 4. Parallelize Tests for Speed

Playwright supports parallel workers. Configure in `playwright.config.json`:

```json
{
  "use": { "headless": true },
  "workers": 4
}
```

### 5. Mock Network Requests

Avoid test flakiness from external APIs. Intercept and mock network calls.

```ts
await page.route('**/api/users', route => {
    route.fulfill({
        status: 200,
        body: JSON.stringify([{ id: 1, name: 'Test User' }])
    });
});
```

→ Source: [Ideal Practices for Playwright Automation Testing — Part 1](/raw/Ideal%20Practices%20for%20playwright%20automation%20testing%20with%20code%20snippets/Ideal%20Practices%20for%20playwright%20automation%20testing%20with%20code%20snippets%20Part-1%20%20by%20Rabi%20Yireh%20%20Medium.md)

---

## UI Testing Types (Checklist)

| Type | Key Checks |
|------|------------|
| **Functional** | All interactive elements work; navigation flows; form submissions; search/filter/sort; modals/tooltips; responsiveness; roles/permissions |
| **Usability** | Intuitive navigation; consistent elements (color, font, button styles); readable text; hover/focus states; loading indicators; A/B readiness |
| **Accessibility** | Keyboard navigation; screen reader support (ARIA labels, semantic HTML); color contrast; alt text on images |
| **Visual Regression** | UI looks correct across browsers and screen sizes; no layout shifts |
| **Performance** | Page load times; time to interactive; Lighthouse scores |

→ Source: [UI Testing Types](/raw/UI%20testing%20Types.%20Ensure%20all%20UI%20elements/UI%20testing%20Types.%20%E2%9C%85%20Ensure%20all%20UI%20elements%20%28buttons%E2%80%A6%20%20by%20Rabi%20Yireh%20%20Medium.md)
