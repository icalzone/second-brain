# Testing

A reference for UI testing strategies, Playwright automation patterns, and JavaScript error debugging.

## UI Testing Types

Different testing layers serve different purposes. Each catches different kinds of bugs:

| Type | What It Tests | Tools |
|---|---|---|
| **Unit Tests** | Individual functions/methods in isolation | Jest, Vitest, xUnit, NUnit |
| **Integration Tests** | Multiple components working together | Supertest, TestContainers |
| **End-to-End (E2E)** | Full user flows through the app | Playwright, Cypress |
| **Visual Regression** | UI appearance hasn't changed | Percy, Chromatic, Playwright screenshots |
| **Accessibility** | WCAG/accessibility compliance | axe-core, Playwright + axe |
| **Performance** | Load times, Core Web Vitals | Lighthouse, k6 |

See `development/raw/UI testing Types.md` for the full breakdown.

---

## Playwright Automation

Playwright is Microsoft's cross-browser E2E testing framework. It supports Chromium, Firefox, and WebKit.

### Setup

```sh
npm init playwright@latest
# or add to existing project
npm install --save-dev @playwright/test
npx playwright install
```

### Test Structure

```ts
import { test, expect } from '@playwright/test';

test('user can login', async ({ page }) => {
  await page.goto('/login');
  await page.fill('[name="email"]', 'user@example.com');
  await page.fill('[name="password"]', 'secret');
  await page.click('button[type="submit"]');
  await expect(page).toHaveURL('/dashboard');
});
```

### Key Locator Strategies (Best Practice Order)

```ts
// 1. By role (most resilient — accessible and semantic)
page.getByRole('button', { name: 'Submit' })

// 2. By label
page.getByLabel('Email address')

// 3. By placeholder
page.getByPlaceholder('Enter your email')

// 4. By text
page.getByText('Sign in')

// 5. By test ID (when semantic options fail)
page.getByTestId('submit-button')
```

### Assertions

```ts
await expect(locator).toBeVisible();
await expect(locator).toHaveText('Expected text');
await expect(locator).toHaveValue('input value');
await expect(page).toHaveURL('/success');
await expect(page).toHaveTitle('Page Title');
```

### Waiting & Timing

```ts
// Wait for navigation
await page.waitForURL('/success');

// Wait for network idle
await page.waitForLoadState('networkidle');

// Wait for element
await page.waitForSelector('[data-loaded="true"]');
```

### Page Object Model Pattern

Organize tests using Page Objects to reduce duplication:

```ts
// pages/LoginPage.ts
export class LoginPage {
  constructor(private page: Page) {}

  async goto() { await this.page.goto('/login'); }
  async login(email: string, password: string) {
    await this.page.getByLabel('Email').fill(email);
    await this.page.getByLabel('Password').fill(password);
    await this.page.getByRole('button', { name: 'Sign in' }).click();
  }
}

// tests/login.spec.ts
test('login', async ({ page }) => {
  const loginPage = new LoginPage(page);
  await loginPage.goto();
  await loginPage.login('user@example.com', 'secret');
  await expect(page).toHaveURL('/dashboard');
});
```

### Debugging

```sh
# Run in headed mode
npx playwright test --headed

# Debug mode (step through)
npx playwright test --debug

# Generate test from browser interaction
npx playwright codegen http://localhost:3000
```

### Playwright Config Tips

```ts
// playwright.config.ts
export default defineConfig({
  use: {
    baseURL: 'http://localhost:3000',
    screenshot: 'only-on-failure',
    video: 'on-first-retry',
  },
});
```

See `development/raw/Ideal Practices for playwright automation testing with code snippets/` for more patterns.

---

## JavaScript Error Debugging

See [javascript](javascript.md) for the full error type reference. Quick debugging checklist:

1. Read the **error type** (TypeError, ReferenceError, etc.)
2. Read the **stack trace** — click the file:line link in DevTools
3. For `undefined`: add a breakpoint or `console.log` before the failing line
4. For `null` access: add a null check or optional chaining (`?.`)
5. Use **DevTools Sources** tab for step-through debugging
6. Use `debugger;` statement to pause execution

---

## Validation

See `development/raw/validation/` for form and data validation patterns.

---

## Sources
- `development/raw/UI testing Types.md`
- `development/raw/Ideal Practices for playwright automation testing with code snippets/`

## Related
- [javascript](javascript.md) — JS error types and patterns
- [optimizely-cms](optimizely-cms.md) — Application Insights for production monitoring
- [README](README.md) — Development wiki home
