---
created: 2025-08-08T14:31:35 (UTC -04:00)
tags: []
source: https://medium.com/@rabiyireh/1-use-fixtures-for-setup-and-teardown-84a947fe5d6b
author: Rabi Yireh
---

# Ideal Practices for playwright automation testing with code snippets Part-1 | by Rabi Yireh | Medium

> ## Excerpt
> “” is published by Rabi Yireh.

---
Ideal Practices for playwright automation testing with code snippets Part-1

## 1\. Use Fixtures for Setup and Teardown

Fixtures help in setting up a consistent testing environment.

```
<span id="af6f" data-selectable-paragraph="">import { test, expect } from '@playwright/test';<br><strong>test.beforeEach</strong>(async ({ page }) =&gt; {<br>    await page.goto('https://example.com');<br>});<br><strong>test('should have a title', async</strong> ({ page }) =&gt; {<br>    await expect(page).toHaveTitle(/Example Domain/);<br>});</span>
```

## 2\. Use Data-Selectors for Stable Locators

Avoid using dynamically generated class names or IDs. Instead, use `data-testid` attributes.

```
<span id="fe5c" data-selectable-paragraph="">&lt;button <strong>data-testid="submit-button</strong>"&gt;Submit&lt;/button&gt;<br><br>test('click the submit button', async ({ page }) =&gt; {<br>    await page.click('<strong>[data-testid="submit-button</strong>"]');<br>    await expect(page.locator('[data-testid="success-message"]')).toBeVisible();<br>});</span>
```

## 3\. Use Assertions for Reliability

Always validate expected states with assertions.

```
<span id="0543" data-selectable-paragraph="">test(<span>'validate button is enabled'</span>, <span>async</span> ({ page }) =&gt; {<br>    <span>const</span> button = page.locator(<span>'[data-testid="submit-button"]'</span>);<br>    <span>await</span> expect(button).toBeEnabled();<br>});</span>
```

## 4\. Parallelize Tests for Speed

Playwright allows parallel test execution for efficiency.

```
<span id="c86b" data-selectable-paragraph=""><br><span>{</span><br>  <span>"use"</span><span>:</span> <span>{</span><br>    <span>"headless"</span><span>:</span> <span><span>true</span></span><br>  <span>}</span><span>,</span><br>  <span>"workers"</span><span>:</span> <span>4</span><br><span>}</span></span>
```

## 5\. Handle Network Requests Efficiently

Mock APIs to avoid dependence on external servers.

```
<span id="afa5" data-selectable-paragraph="">test(<span>'mock API response'</span>, <span>async</span> ({ page }) =&gt; {<br>    <span>await</span> page.route(<span>'**/api/data'</span>, <span>async</span> (route) =&gt; {<br>        <span>await</span> route.fulfill({<br>            status: <span>200</span>,<br>            contentType: <span>'application/json'</span>,<br>            body: JSON.stringify({ success: <span>true</span> })<br>        });<br>    });<br><span>await</span> page.goto(<span>'https://example.com'</span>);<br>    <span>await</span> expect(page.locator(<span>'[data-testid="success-message"]'</span>)).toBeVisible();<br>});</span>
```

## 6\. Use Screenshots for Debugging

Take screenshots to debug failures.

```
<span id="9a3a" data-selectable-paragraph="">test(<span>'capture screenshot on failure'</span>, <span>async</span> ({ page }) =&gt; {<br>    <span>try</span> {<br>        <span>await</span> page.<span>goto</span>(<span>'https://example.com'</span>);<br>        <span>await</span> expect(page.locator(<span>'.non-existent'</span>)).toBeVisible();<br>    } <span>catch</span> (error) {<br>        <span>await</span> page.screenshot({ path: <span>'failure.png'</span> });<br>        <span>throw</span> error;<br>    }<br>});</span>
```

## 7\. Test Across Multiple Viewports

Ensure responsiveness by testing different screen sizes.

```
<span id="1a02" data-selectable-paragraph="">test.use({ viewport: { width: <span>375</span>, height: <span>667</span> } });<br>test(<span>'mobile view test'</span>, <span>async</span> ({ page }) =&gt; {<br>    <span>await</span> page.<span>goto</span>(<span>'https://example.com'</span>);<br>    <span>await</span> expect(page.locator(<span>'.mobile-menu'</span>)).toBeVisible();<br>});</span>
```

## 8\. Leverage Auto-Waiting

Playwright automatically waits for elements before interacting.

```
<span id="8f82" data-selectable-paragraph="">test(<span>'wait for element to be visible'</span>, <span>async</span> ({ page }) =&gt; {<br>    <span>await</span> page.<span>goto</span>(<span>'https://example.com'</span>);<br>    <span>await</span> expect(page.locator(<span>'[data-testid="dynamic-element"]'</span>)).toBeVisible();<br>});</span>
```

## 9\. Run Tests in Headless Mode in CI

Configure CI/CD pipelines for automated tests.

```
<span id="3488" data-selectable-paragraph=""><br><span>name:</span> <span>Playwright</span> <span>Tests</span><br><span>on:</span> [<span>push</span>]<br><span>jobs:</span><br>  <span>test:</span><br>    <span>runs-on:</span> <span>ubuntu-latest</span><br>    <span>steps:</span><br>      <span>-</span> <span>uses:</span> <span>actions/checkout@v3</span><br>      <span>-</span> <span>name:</span> <span>Install</span> <span>dependencies</span><br>        <span>run:</span> <span>npm</span> <span>install</span><br>      <span>-</span> <span>name:</span> <span>Run</span> <span>Playwright</span> <span>tests</span><br>        <span>run:</span> <span>npx</span> <span>playwright</span> <span>test</span> <span>--headless</span></span>
```

## 10\. Use Test Hooks for Setup & Cleanup

Use `beforeEach` and `afterEach` to manage test state.

```
<span id="e294" data-selectable-paragraph="">test.beforeEach(<span>async</span> ({ page }) =&gt; {<br>    <span>await</span> page.goto(<span>'https://example.com'</span>);<br>});<br>test.afterEach(<span>async</span> ({ page }) =&gt; {<br>    <span>await</span> page.close();<br>});</span>
```

## 11\. Use Page Object Model (POM) for Maintainability

Instead of writing locators directly in tests, use **Page Objects** to improve code reuse and maintainability. Example: Creating a Login Page Object

```
<span id="cc39" data-selectable-paragraph=""><br><span>export</span> <span>class</span> <span>LoginPage</span> {<br>    <span>constructor</span>(<span>page</span>) {<br>        <span>this</span>.<span>page</span> = page;<br>        <span>this</span>.<span>usernameInput</span> = page.<span>locator</span>(<span>'[data-testid="username"]'</span>);<br>        <span>this</span>.<span>passwordInput</span> = page.<span>locator</span>(<span>'[data-testid="password"]'</span>);<br>        <span>this</span>.<span>loginButton</span> = page.<span>locator</span>(<span>'[data-testid="login-button"]'</span>);<br>    }<br><br><span>async</span> <span>login</span>(<span>username, password</span>) {<br>        <span>await</span> <span>this</span>.<span>usernameInput</span>.<span>fill</span>(username);<br>        <span>await</span> <span>this</span>.<span>passwordInput</span>.<span>fill</span>(password);<br>        <span>await</span> <span>this</span>.<span>loginButton</span>.<span>click</span>();<br>    }<br>}<br><br><span>import</span> { test, expect } <span>from</span> <span>'@playwright/test'</span>;<br><span>import</span> { <span>LoginPage</span> } <span>from</span> <span>'./loginPage'</span>;<br><span>test</span>(<span>'user can login successfully'</span>, <span>async</span> ({ page }) =&gt; {<br>    <span>const</span> loginPage = <span>new</span> <span>LoginPage</span>(page);<br>    <span>await</span> page.<span>goto</span>(<span>'https://example.com/login'</span>);<br>    <span>await</span> loginPage.<span>login</span>(<span>'testuser'</span>, <span>'password123'</span>);<br>    <span>await</span> <span>expect</span>(page.<span>locator</span>(<span>'[data-testid="dashboard"]'</span>)).<span>toBeVisible</span>();<br>});</span>
```

## 12\. Retry Failed Tests Automatically

Playwright allows retrying tests that fail due to flakiness.This is useful when dealing with **intermittent failures** due to network or timing issues.

```
<span id="4500" data-selectable-paragraph=""><br><span>{</span><br>  <span>"retries"</span><span>:</span> <span>2</span><br><span>}</span></span>
```

## 13\. Run Tests in Different Browsers

Test your app across multiple browsers to ensure cross-browser compatibility.

```
<span id="6d80" data-selectable-paragraph=""><span>import</span> { test, expect } <span>from</span> <span>'@playwright/test'</span>;<br>test.<span>describe</span>(<span>'Cross-browser testing'</span>, <span>() =&gt;</span> {<br>    <span>test</span>(<span>'works in Chromium'</span>, <span>async</span> ({ page }) =&gt; {<br>        <span>await</span> page.<span>goto</span>(<span>'https://example.com'</span>);<br>        <span>await</span> <span>expect</span>(page).<span>toHaveTitle</span>(<span>/Example Domain/</span>);<br>    });<br><span>test</span>(<span>'works in Firefox'</span>, <span>async</span> ({ browser }) =&gt; {<br>        <span>const</span> firefox = <span>await</span> browser.<span>newContext</span>({ <span>browserName</span>: <span>'firefox'</span> });<br>        <span>const</span> page = <span>await</span> firefox.<span>newPage</span>();<br>        <span>await</span> page.<span>goto</span>(<span>'https://example.com'</span>);<br>        <span>await</span> <span>expect</span>(page).<span>toHaveTitle</span>(<span>/Example Domain/</span>);<br>    });<br><span>test</span>(<span>'works in WebKit'</span>, <span>async</span> ({ browser }) =&gt; {<br>        <span>const</span> webkit = <span>await</span> browser.<span>newContext</span>({ <span>browserName</span>: <span>'webkit'</span> });<br>        <span>const</span> page = <span>await</span> webkit.<span>newPage</span>();<br>        <span>await</span> page.<span>goto</span>(<span>'https://example.com'</span>);<br>        <span>await</span> <span>expect</span>(page).<span>toHaveTitle</span>(<span>/Example Domain/</span>);<br>    });<br>});</span>
```

## 14\. Use Test Tagging for Selective Execution

Tag tests to group and run specific ones based on priority.

```
<span id="c6f4" data-selectable-paragraph="">test.describe(<span>'Login Tests'</span>, () =&gt; {<br>    test(<span>'should log in successfully @smoke'</span>, <span>async</span> ({ page }) =&gt; {<br>        <span>await</span> page.goto(<span>'https://example.com/login'</span>);<br>        <span>await</span> expect(page.locator(<span>'h1'</span>)).toContainText(<span>'Welcome'</span>);<br>    });<br>test(<span>'should show an error on invalid login @regression'</span>, <span>async</span> ({ page }) =&gt; {<br>        <span>await</span> page.goto(<span>'https://example.com/login'</span>);<br>        <span>await</span> page.fill(<span>'#username'</span>, <span>'wronguser'</span>);<br>        <span>await</span> page.fill(<span>'#password'</span>, <span>'wrongpassword'</span>);<br>        <span>await</span> page.click(<span>'#login'</span>);<br>        <span>await</span> expect(page.locator(<span>'.error-message'</span>)).toBeVisible();<br>    });<br>});</span>
```

Run only **smoke tests**:

```
<span id="36ff" data-selectable-paragraph="">npx playwright test <span>--grep</span> <span>@smoke</span></span>
```

## 15\. Record Videos & Traces for Debugging

Enable video recording and tracing in Playwright to capture test failures.

```
<span id="f2ba" data-selectable-paragraph="">import { test } <span>from</span> <span>'@playwright/test'</span>;<br>test.use({ video: <span>'on'</span>, trace: <span>'on'</span> });<br>test(<span>'record video on failure'</span>, <span>async</span> ({ page }) =&gt; {<br>    <span>await</span> page.<span>goto</span>(<span>'https://example.com'</span>);<br>    <span>await</span> page.screenshot({ path: <span>'screenshot.png'</span> });<br>});</span>
```

To view traces: npx playwright show-trace trace.zip

## 16\. Run Tests in Headed Mode for Debugging

While developing tests, use **headed mode** to watch the test execution.

```
<span id="068a" data-selectable-paragraph="">npx playwright <span>test</span> --headed</span>
```

Or slow down execution:

```
<span id="8b08" data-selectable-paragraph="">npx playwright test <span>--headed</span> <span>--slow-mo</span> <span>1000</span></span>
```

## 17\. Handle Multi-Tab & Multi-Window Scenarios

If your app opens a new tab or window, handle it properly.

```
<span id="1a69" data-selectable-paragraph=""><span>test</span>(<span>'handle multiple windows'</span>, <span>async</span> ({ page, context }) =&gt; {<br>    <span>await</span> page.<span>goto</span>(<span>'https://example.com'</span>);<br>    <span>const</span> [newPage] = <span>await</span> <span>Promise</span>.<span>all</span>([<br>        context.<span>waitForEvent</span>(<span>'page'</span>),<br>        page.<span>click</span>(<span>'a[target="_blank"]'</span>) <br>    ]);<br><span>await</span> newPage.<span>waitForLoadState</span>();<br>    <span>await</span> <span>expect</span>(newPage).<span>toHaveURL</span>(<span>/new-page/</span>);<br>});</span>
```

## 18\. Emulate Mobile Devices

Test responsive behavior using device emulation.

```
<span id="6482" data-selectable-paragraph="">import { devices } <span>from</span> <span>'@playwright/test'</span>;<br>test.use({ ...devices[<span>'iPhone 12'</span>] });<br><br>test(<span>'check mobile layout'</span>, <span>async</span> ({ page }) =&gt; {<br>    <span>await</span> page.<span>goto</span>(<span>'https://example.com'</span>);<br>    <span>await</span> expect(page.locator(<span>'.mobile-menu'</span>)).toBeVisible();<br>});</span>
```

## 19\. Use Global Configuration for Shared Settings

Instead of setting options in every test, configure them globally.

```
<span id="5b21" data-selectable-paragraph=""><br><span>{</span><br>  <span>"use"</span><span>:</span> <span>{</span><br>    <span>"headless"</span><span>:</span> <span><span>false</span></span><span>,</span><br>    <span>"viewport"</span><span>:</span> <span>{</span> <span>"width"</span><span>:</span> <span>1280</span><span>,</span> <span>"height"</span><span>:</span> <span>720</span> <span>}</span><span>,</span><br>    <span>"screenshot"</span><span>:</span> <span>"on"</span><span>,</span><br>    <span>"video"</span><span>:</span> <span>"retain-on-failure"</span><span>,</span><br>    <span>"trace"</span><span>:</span> <span>"retain-on-failure"</span><br>  <span>}</span><br><span>}</span></span>
```

## 20\. Integrate Playwright with CI/CD

Automate test execution using CI/CD pipelines (GitHub Actions, Jenkins, GitLab, etc.).Example **GitHub Actions** workflow:

```
<span id="2738" data-selectable-paragraph=""><span>name:</span> <span>Playwright</span> <span>Tests</span><br><span>on:</span> [<span>push</span>, <span>pull_request</span>]<br><span>jobs:</span><br>  <span>test:</span><br>    <span>runs-on:</span> <span>ubuntu-latest</span><br>    <span>steps:</span><br>      <span>-</span> <span>uses:</span> <span>actions/checkout@v3</span><br>      <span>-</span> <span>name:</span> <span>Install</span> <span>Dependencies</span><br>        <span>run:</span> <span>npm</span> <span>install</span><br>      <span>-</span> <span>name:</span> <span>Run</span> <span>Playwright</span> <span>Tests</span><br>        <span>run:</span> <span>npx</span> <span>playwright</span> <span>test</span> <span>--reporter=html</span><br>      <span>-</span> <span>name:</span> <span>Upload</span> <span>Test</span> <span>Report</span><br>        <span>uses:</span> <span>actions/upload-artifact@v3</span><br>        <span>with:</span><br>          <span>name:</span> <span>playwright-report</span><br>          <span>path:</span> <span>playwright-report/</span></span>
```

## 21\. Handling Authentication Efficiently

Instead of logging in every test, **reuse authentication state**.

## Save Session State

```
<span id="9f42" data-selectable-paragraph="">test.beforeAll(<span>async</span> ({ browser }) =&gt; {<br>    <span>const</span> context = <span>await</span> browser.newContext();<br>    <span>const</span> page = <span>await</span> context.newPage();<br>    <span>await</span> page.<span>goto</span>(<span>'https://example.com/login'</span>);<br>    <span>await</span> page.fill(<span>'[data-testid="username"]'</span>, <span>'testuser'</span>);<br>    <span>await</span> page.fill(<span>'[data-testid="password"]'</span>, <span>'password123'</span>);<br>    <span>await</span> page.click(<span>'[data-testid="login-button"]'</span>);<br>    <span>await</span> context.storageState({ path: <span>'auth.json'</span> }); <br>    <span>await</span> context.close();<br>});<br><br>test.use({ storageState: <span>'auth.json'</span> });<br>test(<span>'should navigate to dashboard'</span>, <span>async</span> ({ page }) =&gt; {<br>    <span>await</span> page.<span>goto</span>(<span>'https://example.com/dashboard'</span>);<br>    <span>await</span> expect(page.locator(<span>'[data-testid="welcome-message"]'</span>)).toBeVisible();<br>});</span>
```

This dramatically speeds up tests by **avoiding repetitive logins**.

## 22\. Visual Regression Testing

Catch unintended UI changes with **visual diffing**. Take Baseline Snapshots

```
<span id="6a65" data-selectable-paragraph="">test(<span>'homepage should look correct'</span>, <span>async</span> ({ page }) =&gt; {<br>    <span>await</span> page.<span>goto</span>(<span>'https://example.com'</span>);<br>    expect(<span>await</span> page.screenshot()).toMatchSnapshot(<span>'homepage.png'</span>);<br>});</span>
```

Run tests and Playwright will compare new screenshots with the baseline.

## 23\. Test File Uploads

Playwright can handle file uploads directly.

```
<span id="80bf" data-selectable-paragraph="">test(<span>'should upload a file'</span>, <span>async</span> ({ page }) =&gt; {<br>    <span>await</span> page.<span>goto</span>(<span>'https://example.com/upload'</span>);<br>    <span>await</span> page.setInputFiles(<span>'[data-testid="file-upload"]'</span>, <span>'test-file.png'</span>);<br>    <span>await</span> expect(page.locator(<span>'[data-testid="upload-success"]'</span>)).toBeVisible();<br>});</span>
```

## 24\. Test Clipboard and Copy-Paste

Simulate user interactions with the clipboard.

```
<span id="ef70" data-selectable-paragraph="">test(<span>'copy-paste text'</span>, <span>async</span> ({ page }) =&gt; {<br>    <span>await</span> page.<span>goto</span>(<span>'https://example.com'</span>);<br>    <span>await</span> page.locator(<span>'[data-testid="input"]'</span>).fill(<span>'Hello Playwright'</span>);<br>    <span>await</span> page.locator(<span>'[data-testid="input"]'</span>).press(<span>'Control+A'</span>);<br>    <span>await</span> page.locator(<span>'[data-testid="input"]'</span>).press(<span>'Control+C'</span>);<br>    <span>await</span> page.locator(<span>'[data-testid="input"]'</span>).press(<span>'Control+V'</span>);<br>    <span>await</span> expect(page.locator(<span>'[data-testid="input"]'</span>)).toHaveValue(<span>'Hello PlaywrightHello Playwright'</span>);<br>});</span>
```

## 25\. Simulate Geolocation

Test location-based features using Playwright’s geolocation capabilities.

```
<span id="0ab9" data-selectable-paragraph="">test.use({ geolocation: { latitude: <span>37.7749</span>, longitude: <span>-122.4194</span> } });<br>test(<span>'should detect user location'</span>, <span>async</span> ({ page }) =&gt; {<br>    <span>await</span> page.<span>goto</span>(<span>'https://example.com/location'</span>);<br>    <span>await</span> expect(page.locator(<span>'[data-testid="user-location"]'</span>)).toContainText(<span>'San Francisco'</span>);<br>});</span>
```

## 26\. Simulate Network Speed (Throttling)

Test how your app behaves in slow network conditions.

```
<span id="0356" data-selectable-paragraph=""><span>test</span>(<span>'test in slow network'</span>, <span>async</span> ({ page, context }) =&gt; {<br>    <span>await</span> context.<span>route</span>(<span>'**/*'</span>, <span><span>route</span> =&gt;</span><br>        route.<span>continue</span>({ <span>latency</span>: <span>2000</span> }) <br>    );<br>    <span>await</span> page.<span>goto</span>(<span>'https://example.com'</span>);<br>});<br>-------------<br><span>test</span>(<span>'Test with slow network'</span>, <span>async</span> ({ page }) =&gt; {<br>  <span>await</span> page.<span>goto</span>(<span>'https://example.com'</span>, { <span>waitUntil</span>: <span>'domcontentloaded'</span> });<br>  <span>await</span> page.<span>emulateNetworkConditions</span>({<br>    <span>download</span>: <span>500</span>,  <br>    <span>upload</span>: <span>500</span>,    <br>    <span>latency</span>: <span>200</span>,   <br>  });<br>  <br>  <span>const</span> loadStart = <span>Date</span>.<span>now</span>();<br>  <span>await</span> page.<span>reload</span>();<br>  <span>const</span> loadTime = <span>Date</span>.<span>now</span>() - loadStart;<br>  <span>console</span>.<span>log</span>(<span>`Page loaded in slow network in <span>${loadTime}</span> ms`</span>);<br>});</span>
```

## 27\. Simulate Dark Mode

Test UI behavior in **dark mode**.

```
<span id="590e" data-selectable-paragraph="">test.use({ colorScheme: <span>'dark'</span> });<br>test(<span>'should display dark mode correctly'</span>, <span>async</span> ({ page }) =&gt; {<br>    <span>await</span> page.<span>goto</span>(<span>'https://example.com'</span>);<br>    <span>await</span> expect(page.locator(<span>'body'</span>)).toHaveCSS(<span>'background-color'</span>, <span>'rgb(0, 0, 0)'</span>);<br>});</span>
```

## 28\. Interact with Shadow DOM Elements

Some frameworks (e.g., Web Components, Salesforce) use **Shadow DOM**, requiring `shadowRoot` access.

```
<span id="83da" data-selectable-paragraph="">test(<span>'should handle shadow DOM elements'</span>, <span>async</span> ({ page }) =&gt; {<br>    <span>await</span> page.<span>goto</span>(<span>'https://example.com'</span>);<br>    <span>const</span> shadowHost = page.locator(<span>'custom-element'</span>);<br>    <span>const</span> shadowElement = shadowHost.locator(<span>'&gt;&gt;&gt; #shadow-child'</span>);<br>    <span>await</span> expect(shadowElement).toBeVisible();<br>});</span>
```

## 29\. Test Progressive Web Apps (PWAs)

Verify **Service Workers** and offline behavior.

```
<span id="2869" data-selectable-paragraph="">test(<span>'should work offline'</span>, <span>async</span> ({ page, context }) =&gt; {<br>    <span>await</span> page.<span>goto</span>(<span>'https://example.com'</span>);<br>    <span>await</span> context.serviceWorkers();<br>    <span>await</span> context.setOffline(<span>true</span>);<br>    <span>await</span> page.reload();<br>    <span>await</span> expect(page.locator(<span>'[data-testid="offline-message"]'</span>)).toBeVisible();<br>});</span>
```

## 30\. Handle Dynamic Captcha Verification

For automated testing, **bypass CAPTCHAs** by mocking requests.

```
<span id="72cf" data-selectable-paragraph="">test(<span>'bypass CAPTCHA'</span>, <span>async</span> ({ page }) =&gt; {<br>    <span>await</span> page.route(<span>'**/captcha-verification'</span>, <span>async</span> (route) =&gt; {<br>        <span>await</span> route.fulfill({ status: <span>200</span>, body: JSON.stringify({ success: <span>true</span> }) });<br>    });<br>    <span>await</span> page.goto(<span>'https://example.com/login'</span>);<br>});</span>
```

## 31\. Measure Performance Metrics

Capture load times and **performance data**.

```
<span id="3cda" data-selectable-paragraph=""><span>test</span>(<span>'should measure page load time'</span>, <span>async</span> ({ page }) =&gt; {<br>    <span>await</span> page.<span>goto</span>(<span>'https://example.com'</span>);<br>    <span>const</span> metrics = <span>await</span> page.evaluate(<span>() =&gt;</span> <span>JSON</span>.<span>stringify</span>(<span>window</span>.<span>performance</span>));<br>    <span>console</span>.<span>log</span>(metrics);<br>});<br><span>test</span>(<span>'Profile page load performance'</span>, <span>async</span> ({ page }) =&gt; {<br>    <span>await</span> page.<span>goto</span>(<span>'https://example.com'</span>);<br>    <br>    <span>const</span> profile = <span>await</span> page.evaluate(<span>() =&gt;</span> {<br>        <span>return</span> <span>window</span>.<span>performance</span>.<span>timing</span>;<br>    });<br><span>console</span>.<span>log</span>(<span>'Page Load Time:'</span>, profile.<span>loadEventEnd</span> - profile.<span>navigationStart</span>);<br>});</span>
```

// Measure page load time  
const loadTime = await page.evaluate(() => {  
const start = window.performance.getEntriesByName(‘start’)\[0\].startTime;  
const end = window.performance.timing.domContentLoadedEventEnd;  
return end — start;  
});

console.log(\`Page load time: ${loadTime} milliseconds\`);

// Capture resource usage metrics  
const resourceUsage = await page.evaluate(() => {  
return {  
cpuUsage: window.performance.now(), // Example CPU usage metric  
memoryUsage: window.performance.memory.usedJSHeapSize // Example memory usage metric  
};  
});

## 32\. Automate Email Confirmation in UI Tests

Use a fake SMTP server to automate **email verification**.

```
<span id="ab46" data-selectable-paragraph="">import nodemailer <span>from</span> <span>'nodemailer'</span>;<br><span>const</span> <span>transporter</span> = nodemailer.<span>createTransport</span>({<br>    <span>host</span>: <span>'localhost'</span>,<br>    <span>port</span>: <span>1025</span>, // Example SMTP server<br>    <span>secure</span>: <span>false</span><br>});<br><span>test</span>(<span>'should receive verification email'</span>, <span>async</span> () =&gt; {<br>    <span>const</span> mailOptions = {<br>        <span>from</span>: <span>'no-reply@example.com'</span>,<br>        <span>to</span>: <span>'testuser@example.com'</span>,<br>        <span>subject</span>: <span>'Verify Your Email'</span><br>    };<br>     await transporter.<span>sendMail</span>(mailOptions);<br>});</span>
```

## 33\. Run Tests in Docker

Use **Dockerized Playwright** for a clean environment.

```
<span id="f7be" data-selectable-paragraph="">docker run --<span>rm</span> -v $(<span>pwd</span>):/app mcr.microsoft.com/playwright npx playwright <span>test</span></span>
```

## 34\. Generate Reports in Multiple Formats

Playwright supports multiple test reports.

```
<span id="471d" data-selectable-paragraph="">npx playwright <span>test</span> --reporter=html,junit</span>
```

Or configure `playwright.config.js`:

```
<span id="3f85" data-selectable-paragraph="">{<br>  <span>"reporter"</span>: <span>[["list"], ["json", { "outputFile": "results.json" }]]</span><br>}</span>
```

## 35\. Handle Multi-Factor Authentication (MFA)

For apps with MFA, use **OTP or session tokens**.

```
<span id="e28e" data-selectable-paragraph="">test(<span>'bypass OTP'</span>, <span>async</span> ({ page }) =&gt; {<br>    <span>await</span> page.route(<span>'**/otp-verification'</span>, <span>async</span> (route) =&gt; {<br>        <span>await</span> route.fulfill({ status: <span>200</span>, body: JSON.stringify({ success: <span>true</span>, otp: <span>'123456'</span> }) });<br>    });<br>});</span>
```

## 36\. Automate Mobile Testing with Playwright and Appium

For hybrid apps, combine **Playwright with Appium** for deeper mobile testing.

```
<span id="1997" data-selectable-paragraph="">import { remote } <span>from</span> <span>'webdriverio'</span>;<br><span>const</span> <span>driver</span> = await <span>remote</span>({<br>    <span>capabilities</span>: {<br>        <span>platformName</span>: <span>'Android'</span>,<br>        <span>deviceName</span>: <span>'emulator-5554'</span>,<br>        <span>browserName</span>: <span>'chrome'</span><br>    }<br>});<br>await driver.<span>url</span>(<span>'https://example.com'</span>);</span>
```

## 37\. Schedule Tests with a Cron Job

Automate test execution at fixed intervals.

**MINUTE (0–59), HOUR (0–23), DAY (1–31), MONTH (1–12), DAY OF THE WEEK (0–6)**

Press enter or click to view image in full size

![](https://miro.medium.com/v2/resize:fit:700/0*3-Rkv_tIZ3I71i61.png)

```
<span id="c875" data-selectable-paragraph="">crontab -e  0 0 * * * <span>cd</span> /path-to-tests &amp;&amp; npx playwright <span>test</span></span>
```

## 38\. Hybrid Testing: Playwright + API Requests

Instead of always interacting with the UI, use **API requests** to speed up test setup. Example: Login via API, then Navigate to UI

```
<span id="4d4c" data-selectable-paragraph="">test(<span>'Login via API, then test UI'</span>, <span>async</span> ({ request, page }) =&gt; {<br>    <span>const</span> response = <span>await</span> request.post(<span>'https://example.com/api/login'</span>, {<br>        data: { username: <span>'testuser'</span>, password: <span>'password123'</span> }<br>    });<br>    <span>const</span> { token } = <span>await</span> response.json();<br><br>    <span>await</span> page.context().addCookies([{ name: <span>'auth_token'</span>, <span>value</span>: token, domain: <span>'example.com'</span> }]);<br>    <span>await</span> page.<span>goto</span>(<span>'https://example.com/dashboard'</span>);<br>    <span>await</span> expect(page.locator(<span>'[data-testid="welcome-message"]'</span>)).toBeVisible();<br>});</span>
```

## 39\. Use Playwright to Mock API Calls

Simulate server responses to test UI behavior without real backend dependencies.Example: Mock API Response

```
<span id="3ec9" data-selectable-paragraph="">test(<span>'Mock API response'</span>, <span>async</span> ({ page }) =&gt; {<br>    <span>await</span> page.route(<span>'**/api/user'</span>, <span>async</span> (route) =&gt; {<br>        route.fulfill({<br>            status: <span>200</span>,<br>            contentType: <span>'application/json'</span>,<br>            body: JSON.stringify({ name: <span>'Mock User'</span>, age: <span>30</span> })<br>        });<br>    });<br><span>await</span> page.goto(<span>'https://example.com/profile'</span>);<br>    <span>await</span> expect(page.locator(<span>'[data-testid="user-name"]'</span>)).toHaveText(<span>'Mock User'</span>);<br>});.</span>
```

## 41\. CI/CD Optimization: Run Specific Tests on Code Changes

Instead of running **all tests on every commit**, run only relevant tests.

## Example: Run Tests Related to Changed Files

```
<span id="2078" data-selectable-paragraph=""><span>name:</span> <span>Selective</span> <span>Playwright</span> <span>Tests</span><br><span>on:</span> [<span>push</span>, <span>pull_request</span>]<br><span>jobs:</span><br>  <span>test:</span><br>    <span>runs-on:</span> <span>ubuntu-latest</span><br>    <span>steps:</span><br>      <span>-</span> <span>name:</span> <span>Get</span> <span>Changed</span> <span>Files</span><br>        <span>id:</span> <span>changed-files</span><br>        <span>uses:</span> <span>dorny/paths-filter@v2</span><br>        <span>with:</span><br>          <span>filters:</span> <span>|<br>            ui:<br>              - 'src/components/**'<br>            api:<br>              - 'src/services/**'<br></span><span>-</span> <span>name:</span> <span>Run</span> <span>UI</span> <span>Tests</span><br>        <span>if:</span> <span>steps.changed-files.outputs.ui</span> <span>==</span> <span>'true'</span><br>        <span>run:</span> <span>npx</span> <span>playwright</span> <span>test</span> <span>--grep</span> <span>@ui</span><br><span>-</span> <span>name:</span> <span>Run</span> <span>API</span> <span>Tests</span><br>        <span>if:</span> <span>steps.changed-files.outputs.api</span> <span>==</span> <span>'true'</span><br>        <span>run:</span> <span>npx</span> <span>playwright</span> <span>test</span> <span>--grep</span> <span>@api</span></span>
```

## 42\. Playwright with React: Test Component Behavior

For **React apps**, test components in isolation.

## Example: Test React Component’s State

```
<span id="c870" data-selectable-paragraph="">test(<span>'Counter increments correctly'</span>, <span>async</span> ({ page }) =&gt; {<br>    <span>await</span> page.<span>goto</span>(<span>'http://localhost:3000'</span>);<br>    <br>    <span>const</span> button = page.locator(<span>'[data-testid="increment-button"]'</span>);<br>    <span>await</span> button.click();<br>    <span>await</span> expect(page.locator(<span>'[data-testid="counter-value"]'</span>)).toHaveText(<span>'1'</span>);<br>});</span>
```

## 43\. Test GraphQL APIs with Playwright

Mock and test **GraphQL API calls** within UI tests. Example: Mock GraphQL Response

```
<span id="cada" data-selectable-paragraph=""><span>test</span>(<span>'Mock GraphQL response'</span>, <span>async</span> ({ page }) =&gt; {<br>    await page.<span>route</span>(<span>'**/graphql'</span>, <span>async</span> (route) =&gt; {<br>        route.<span>fulfill</span>({<br>            <span>status</span>: <span>200</span>,<br>            <span>contentType</span>: <span>'application/json'</span>,<br>            <span>body</span>: JSON.<span>stringify</span>({<br>                <span>data</span>: {<br>                    <span>user</span>: { <span>id</span>: <span>"1"</span>, <span>name</span>: <span>"Mock User"</span> }<br>                }<br>            })<br>        });<br>    });<br>    await page.<span>goto</span>(<span>'https://example.com/profile'</span>);<br>    await <span>expect</span>(page.<span>locator</span>(<span>'[data-testid="user-name"]'</span>)).<span>toHaveText</span>(<span>'Mock User'</span>);<br>});</span>
```

## 44\. Playwright with Service Workers (PWA Testing)

Test **Progressive Web App (PWA) behaviors** like offline caching.Example: Verify Service Worker Registration

```
<span id="47b3" data-selectable-paragraph="">test(<span>'Verify service worker registration'</span>, <span>async</span> ({ page }) =&gt; {<br>    <span>await</span> page.goto(<span>'https://example.com'</span>);<br>    <span>const</span> registration = <span>await</span> page.evaluate(<span>async</span> () =&gt; {<br>        <span>return</span> navigator.serviceWorker.getRegistration();<br>    });<br>    console.log(registration ? <span>"Service Worker Registered"</span> : <span>"No Service Worker"</span>);<br>});</span>
```

## 45\. Playwright + Database Seeding (Test Data)

Instead of relying on UI to set up test data, **seed the database**.Example: Reset Database Before Tests

```
<span id="0c79" data-selectable-paragraph="">test.beforeEach(<span>async</span> ({ request }) =&gt; {<br>    <span>await</span> request.post(<span>'https://example.com/api/reset-database'</span>);<br>});</span>
```

## 46\. Parallel Execution of Different Test Suites

Optimize test execution by running **multiple suites in parallel**. Example: Run UI and API Tests in Parallel.Drastically reduces test execution time.

```
<span id="0f8f" data-selectable-paragraph="">npx playwright <span>test</span> tests/ui/ --shard=1/2 &amp; npx playwright <span>test</span> tests/api/ --shard=2/2</span>
```

## 47\. Auto-Retry Flaky Tests with Conditional Logic

Instead of retrying **all** failed tests, retry only specific flaky ones.Example: Retry Only Certain Tests

```
<span id="8db7" data-selectable-paragraph="">test(<span>'retry only if timeout occurs'</span>, <span>async</span> ({ page }, testInfo) =&gt; {<br>    <span>if</span> (testInfo.retry) {<br>        console.log(<span>'Retrying due to timeout'</span>);<br>    }<br>    <span>await</span> page.<span>goto</span>(<span>'https://example.com'</span>);<br>});</span>
```

## 48\. Run Tests in Different User Roles

Test **RBAC (Role-Based Access Control)** by switching users.Example: Test Different Roles

```
<span id="2721" data-selectable-paragraph="">test(<span>'admin can access settings'</span>, <span>async</span> ({ page }) =&gt; {<br>    <span>await</span> page.<span>goto</span>(<span>'https://example.com/login?role=admin'</span>);<br>    <span>await</span> expect(page.locator(<span>'[data-testid="settings"]'</span>)).toBeVisible();<br>});</span>
```

## 49\. Test iFrames and Embedded Content

Handle **embedded content** (e.g., payment gateways, ads).Example: Interact with iFrame Content

```
<span id="e374" data-selectable-paragraph="">test(<span>'handle iframe content'</span>, <span>async</span> ({ page }) =&gt; {<br>    <span>await</span> page.<span>goto</span>(<span>'https://example.com'</span>);<br>    <span>const</span> frame = page.frameLocator(<span>'[data-testid="payment-iframe"]'</span>);<br>    <span>await</span> frame.locator(<span>'[data-testid="pay-now"]'</span>).click();<br>});</span>
```

## 50\. Automate CAPTCHA Handling Using AI (Experimental)

If you must automate CAPTCHA, integrate **AI-based solvers**.Example: Solve CAPTCHA with AI (External API)

```
<span id="b415" data-selectable-paragraph="">test(<span>'solve CAPTCHA'</span>, <span>async</span> ({ page }) =&gt; {<br>    <span>const</span> image = <span>await</span> page.screenshot({ path: <span>'captcha.png'</span> });<br>    <span>const</span> solution = <span>await</span> solveCaptchaWithAI(image); <br>    <span>await</span> page.fill(<span>'[data-testid="captcha-input"]'</span>, solution);<br>});<br><br><br><span>const</span> captchaSolution = <span>await</span> solveCaptchaWith2Captcha(captchaImage);</span>
```

## 51\. Capture Network Traffic (HAR Files)

Record network requests and analyze API calls.Example: Save Network Traffic to HAR File

```
<span id="d265" data-selectable-paragraph="">test(<span>'Record network traffic'</span>, <span>async</span> ({ page, browserContext }) =&gt; {<br>    <span>await</span> browserContext.tracing.start({ screenshots: <span>true</span>, snapshots: <span>true</span> });<br>    <span>await</span> page.<span>goto</span>(<span>'https://example.com'</span>);<br>    <span>await</span> browserContext.tracing.stop({ path: <span>'network-trace.har'</span> });<br>});</span>
```

-   Debug failed API calls in CI.
-   Analyze performance bottlenecks.

## 52\. Test Multiple Browser Tabs

Simulate multi-tab workflows.

## Example: Open Two Tabs and Sync Actions

```
<span id="8f4d" data-selectable-paragraph="">test(<span>'Test multi-tab behavior'</span>, <span>async</span> ({ browser }) =&gt; {<br>    <span>const</span> context = <span>await</span> browser.newContext();<br>    <span>const</span> page1 = <span>await</span> context.newPage();<br>    <span>const</span> page2 = <span>await</span> context.newPage();<br>    <span>await</span> page1.<span>goto</span>(<span>'https://example.com'</span>);<br>    <span>await</span> page2.<span>goto</span>(<span>'https://example.com'</span>);<br>    <span>await</span> page1.fill(<span>'[data-testid="search"]'</span>, <span>'Playwright'</span>);<br>    <span>const</span> searchValue = <span>await</span> page2.inputValue(<span>'[data-testid="search"]'</span>);<br>expect(searchValue).toBe(<span>'Playwright'</span>);<br>});</span>
```

## 53\. Bypass CORS Issues in API Testing

Avoid CORS errors when testing **cross-origin API requests**.Example: Modify CORS Headers.Ensures API requests **don’t fail due to CORS in tests**.

```
<span id="c641" data-selectable-paragraph="">test(<span>'Bypass CORS for API request'</span>, <span>async</span> ({ page }) =&gt; {<br>    <span>await</span> page.route(<span>'**/api/data'</span>, <span>async</span> (route) =&gt; {<br>        <span>const</span> response = <span>await</span> route.fetch();<br>        <span>const</span> headers = { ...response.headers(), <span>'Access-Control-Allow-Origin'</span>: <span>'*'</span> };<br>        <span>await</span> route.fulfill({ response, headers });<br>    });<br><span>await</span> page.goto(<span>'https://example.com'</span>);<br>});</span>
```

## 54\. Mobile Testing: Simulate Different Devices

Playwright can mimic **iOS, Android, and tablets**.Example: Run Tests on iPhone 14 Pro

```
<span id="6093" data-selectable-paragraph="">test.use({ viewport: { width: <span>430</span>, height: <span>932</span> } });<br>test(<span>'Mobile test on iPhone 14 Pro'</span>, <span>async</span> ({ page }) =&gt; {<br>    <span>await</span> page.<span>goto</span>(<span>'https://example.com'</span>);<br>    <span>await</span> expect(page.locator(<span>'[data-testid="mobile-nav"]'</span>)).toBeVisible();<br>});</span>
```

Tests **mobile responsiveness** and UI behavior on real-world devices.

## 55\. Automate Payments (Stripe, PayPal)

Use test payment environments to **simulate transactions**.Example: Automate Stripe Payment

```
<span id="e543" data-selectable-paragraph="">test(<span>'Stripe test payment'</span>, <span>async</span> ({ page }) =&gt; {<br>    <span>await</span> page.<span>goto</span>(<span>'https://example.com/checkout'</span>);<br>    <span>await</span> page.fill(<span>'[data-testid="card-number"]'</span>, <span>'4242424242424242'</span>);<br>    <span>await</span> page.fill(<span>'[data-testid="expiry-date"]'</span>, <span>'12/25'</span>);<br>    <span>await</span> page.fill(<span>'[data-testid="cvc"]'</span>, <span>'123'</span>);<br>    <span>await</span> page.click(<span>'[data-testid="pay-button"]'</span>);<br>    <span>await</span> expect(page.locator(<span>'[data-testid="success-message"]'</span>)).toBeVisible();<br>});</span>
```

## 56\. Test Progressive Web Apps (PWAs) in Offline Mode

Verify if PWAs work **without an internet connection**. Example: Simulate Offline Mode

```
<span id="a44f" data-selectable-paragraph="">test(<span>'PWA should work offline'</span>, <span>async</span> ({ page, context }) =&gt; {<br>    <span>await</span> page.<span>goto</span>(<span>'https://example.com'</span>);<br>    <span>await</span> context.setOffline(<span>true</span>);<br>    <span>await</span> page.reload();<br>    <span>await</span> expect(page.locator(<span>'[data-testid="offline-mode"]'</span>)).toBeVisible();<br>});</span>
```

## 57\. Headless Mode Debugging

Run tests in headless mode but capture **screenshots and videos** for debugging. Example: Enable Video Recording in Headless Mode

```
<span id="12b2" data-selectable-paragraph="">test.use({ video: <span>'on'</span> });<br>test(<span>'Record test session'</span>, <span>async</span> ({ page }) =&gt; {<br>    <span>await</span> page.<span>goto</span>(<span>'https://example.com'</span>);<br>    <span>await</span> page.click(<span>'[data-testid="button"]'</span>);<br>});</span>
```

## 59\. Run Playwright Tests in Docker CI/CD

For **consistent test execution** across environments.Example: Run Playwright in Docker

```
<span id="5cc6" data-selectable-paragraph="">docker run --<span>rm</span> -v $(<span>pwd</span>):/app -w /app mcr.microsoft.com/playwright npx playwright <span>test</span></span>
```

## 60\. Performance Testing with Playwright

Measure **page load times, render speeds, and API response times**. Example: Capture Load Time Metrics

```
<span id="1d43" data-selectable-paragraph=""><span>test</span>(<span>'Check page load performance'</span>, <span>async</span> ({ page }) =&gt; {<br>    <span>await</span> page.<span>goto</span>(<span>'https://example.com'</span>);<br>    <span>const</span> metrics = <span>await</span> page.evaluate(<span>() =&gt;</span> <span>JSON</span>.<span>stringify</span>(<span>window</span>.<span>performance</span>));<br>    <span>console</span>.<span>log</span>(metrics);<br>});</span>
```

## 61\. Testing desktop app

import { test, expect } from ‘@playwright/test’;

test(‘Should open a window and display a title’, async ({ browser }) => {  
const application = await browser.launch();  
const page = await application.newPage();  
await page.goto(‘path/to/your/application’);  
await expect(page.locator(‘h1’)).toBeVisible();  
await expect(page.locator(‘h1’)).toHaveText(‘My Desktop App Title’);  
await application.close();  
});

## Automate Push Notifications

Test **browser push notifications** using Playwright. Example: Handle Notification Popups

```
<span id="7d21" data-selectable-paragraph="">test(<span>'Allow push notifications'</span>, <span>async</span> ({ page, context }) =&gt; {<br>    <span>await</span> context.grantPermissions([<span>'notifications'</span>]);<br>    <span>await</span> page.<span>goto</span>(<span>'https://example.com'</span>);<br>    <span>await</span> expect(page.locator(<span>'[data-testid="push-notification"]'</span>)).toBeVisible();<br>});</span>
```

## 65\. Security Testing: XSS (Cross-Site Scripting) Protection

Test for **XSS vulnerabilities** in your application by injecting malicious scripts. Example: Test for XSS Injection

```
<span id="ff15" data-selectable-paragraph="">test(<span>'XSS vulnerability test'</span>, <span>async</span> ({ page }) =&gt; {<br>    <span>const</span> maliciousScript = `&lt;img src=<span>"x"</span> onerror=<span>"alert('XSS')"</span>&gt;`;<br>    <span>await</span> page.<span>goto</span>(<span>'https://example.com/search'</span>);<br>    <span>await</span> page.fill(<span>'[data-testid="search-input"]'</span>, maliciousScript);<br>    <span>await</span> page.click(<span>'[data-testid="search-button"]'</span>);<br>    <span>await</span> expect(page.locator(<span>'text=XSS'</span>)).<span>not</span>.toBeVisible();<br>});</span>
```

## 66\. Simulate Geolocation Changes

Test how your app reacts when the user is in **different locations**. Example: Change Geolocation

```
<span id="adfe" data-selectable-paragraph="">test(<span>'Test geolocation change'</span>, <span>async</span> ({ page, context }) =&gt; {<br>    <span>await</span> context.setGeolocation({ latitude: <span>40.7128</span>, longitude: <span>-74.0060</span> });  <br>    <span>await</span> page.<span>goto</span>(<span>'https://example.com/location-based'</span>);<br>    <span>await</span> expect(page.locator(<span>'[data-testid="city-name"]'</span>)).toHaveText(<span>'New York'</span>);<br>});</span>
```

## 79\. Automate Browser Cache Control

Simulate scenarios where users clear **cache or cookies**.Example: Disable Cache for Specific Test

```
<span id="f768" data-selectable-paragraph=""><br> <span>await</span> context.clearCookies({ name: <span>'session_id'</span> });<br><span>await</span> context.addCookies([{ name: <span>'sessionId'</span>, value: <span>'abc123'</span>, domain: <span>'.example.com'</span>, path: <span>'/'</span> }]);<br>test(<span>'Disable cache for testing'</span>, <span>async</span> ({ page, context }) =&gt; {<br>    <span>await</span> context.addInitScript(() =&gt; {<br>        <span>Object</span>.defineProperty(navigator, <span>'serviceWorker'</span>, { value: <span>null</span> });<br>    });<br>    <span>await</span> page.goto(<span>'https://example.com'</span>);<br>});</span>
```

## 80\. Test Browser Storage (LocalStorage, SessionStorage)

Test that **browser storage mechanisms** are behaving as expected. Example: Manipulate Local Storage

**Local Storage:**Storing a user’s preferred language settings, so they remain the same even after the browser is closed and reopened.Keeping track of items in a shopping cart, even if the user closes and reopens the browser.

**Session Storage:**Storing form data as the user fills it out, so they don’t lose it if they refresh the page.Remembering the user’s login information for the duration of their current session.

```
<span id="651b" data-selectable-paragraph="">  <span>await</span> page.evaluate(<span>() =&gt;</span> <span>localStorage</span>.<span>clear</span>());<br>  <span>await</span> page.evaluate(<span>() =&gt;</span> sessionStorage.<span>clear</span>());<br><span>test</span>(<span>'Test LocalStorage manipulation'</span>, <span>async</span> ({ page }) =&gt; {<br>    <span>await</span> page.<span>goto</span>(<span>'https://example.com'</span>);<br>    <span>await</span> page.evaluate(<span>() =&gt;</span> {<br>        <span>localStorage</span>.<span>setItem</span>(<span>'user'</span>, <span>'testuser'</span>);<br>    });<br>    <span>const</span> user = <span>await</span> page.evaluate(<span>() =&gt;</span> <span>localStorage</span>.<span>getItem</span>(<span>'user'</span>));<br>    <span>expect</span>(user).<span>toBe</span>(<span>'testuser'</span>);<br>});</span>
```

## 81\. Simulate Network Throttling (Slow Connections)

Test how the app performs under **poor network conditions**.Example: Test Slow Network Simulation

```
<span id="183a" data-selectable-paragraph="">test(<span>'Test slow network conditions'</span>, <span>async</span> ({ page, context }) =&gt; {<br>    <span>await</span> context.setOffline(<span>false</span>);<br>    <span>await</span> context.setNetworkConditions({<br>        offline: <span>false</span>,<br>        download: <span>500</span> * <span>1024</span>,  <br>        upload: <span>500</span> * <span>1024</span>,    <br>        latency: <span>1000</span>          <br>    });<br><span>await</span> page.goto(<span>'https://example.com'</span>);<br>    <span>await</span> expect(page.locator(<span>'[data-testid="slow-load-element"]'</span>)).toBeVisible();<br>});<br>-----------------------<br>test(<span>'Test slow network resilience'</span>, <span>async</span> ({ page }) =&gt; {<br>  <span>await</span> page.route(<span>'**/*'</span>, route =&gt; {<br>    route.<span>continue</span>({ delay: <span>5000</span> }); <br>  });<br>  <span>await</span> page.goto(<span>'https://example.com'</span>);<br>  <span>await</span> expect(page.locator(<span>'[data-testid="loading-indicator"]'</span>)).toBeVisible();<br>});</span>
```

## 84\. Trigger Mouse Hover Events

Test **hover-based interactions** (e.g., tooltips, menus).Example: Hover to Display Tooltip

```
<span id="a7ae" data-selectable-paragraph="">test(<span>'Hover over to display tooltip'</span>, <span>async</span> ({ page }) =&gt; {<br>    <span>await</span> page.<span>goto</span>(<span>'https://example.com'</span>);<br>    <span>const</span> button = page.locator(<span>'[data-testid="tooltip-button"]'</span>);<br>    <span>await</span> button.hover();<br>    <span>await</span> expect(page.locator(<span>'[data-testid="tooltip-text"]'</span>)).toBeVisible();<br>});</span>
```

## 86\. Automate Popups and Modals

Handle popups or **alert modals** that interrupt workflows.Example: Test Modal Dialog

```
<span id="e334" data-selectable-paragraph="">test(<span>'Test modal dialog'</span>, <span>async</span> ({ page }) =&gt; {<br>    <span>await</span> page.goto(<span>'https://example.com'</span>);<br>    <span>await</span> page.click(<span>'[data-testid="open-modal-button"]'</span>);<br>    <span>await</span> expect(page.locator(<span>'[data-testid="modal-dialog"]'</span>)).toBeVisible();<br>    <span>await</span> page.click(<span>'[data-testid="close-modal-button"]'</span>);<br>    <span>await</span> expect(page.locator(<span>'[data-testid="modal-dialog"]'</span>)).not.toBeVisible();<br>});<br><br>----------------------------<br>test(<span>'Test alert handling'</span>, <span>async</span> ({ page }) =&gt; {<br>    page.<span>on</span>(<span>'dialog'</span>, <span>async</span> (dialog) =&gt; {<br>        expect(dialog.message()).toBe(<span>'Are you sure?'</span>);<br>        <span>await</span> dialog.accept();<br>    });<br>    <br>    <span>await</span> page.goto(<span>'https://example.com'</span>);<br>    <span>await</span> page.click(<span>'[data-testid="open-alert-button"]'</span>);<br>});</span>
```

## 104\. Test Database Integrity

Ensure **data integrity** after operations like form submission or API requests. Example: Validate Data Integrity

```
<span id="d3bf" data-selectable-paragraph="">test(<span>'Validate database changes after form submission'</span>, <span>async</span> ({ page }) =&gt; {<br>    <span>await</span> page.<span>goto</span>(<span>'https://example.com/form'</span>);<br>    <span>await</span> page.fill(<span>'[data-testid="name-input"]'</span>, <span>'Test User'</span>);<br>    <span>await</span> page.click(<span>'[data-testid="submit-button"]'</span>);<br>    <br>    <span>const</span> dbRecord = <span>await</span> getDbRecord(<span>'Test User'</span>);<br>    expect(dbRecord.name).toBe(<span>'Test User'</span>);<br>});</span>
```

## 105\. Browser Context Isolation

Run tests in **separate browser contexts** to simulate **multiple users** on the same machine.Example: Run Tests in Isolated Browser Contexts

```
<span id="3e3b" data-selectable-paragraph="">test(<span>'Test multiple users in parallel'</span>, <span>async</span> ({ browser }) =&gt; {<br>    <span>const</span> context1 = <span>await</span> browser.newContext();<br>    <span>const</span> context2 = <span>await</span> browser.newContext();<br>    <span>const</span> page1 = <span>await</span> context1.newPage();<br>    <span>const</span> page2 = <span>await</span> context2.newPage();<br>    <span>await</span> page1.<span>goto</span>(<span>'https://example.com'</span>);<br>    <span>await</span> page2.<span>goto</span>(<span>'https://example.com'</span>);<br>    <span>await</span> expect(page1.locator(<span>'[data-testid="user1"]'</span>)).toBeVisible();<br>    <span>await</span> expect(page2.locator(<span>'[data-testid="user2"]'</span>)).toBeVisible();<br>});</span>
```

## 106\. Network Interception: Block Ads or Trackers

Simulate **network conditions** where ads or trackers are blocked.Example: Block Ads and Trackers

```
<span id="ff52" data-selectable-paragraph="">test(<span>'Block ads and trackers during test'</span>, <span>async</span> ({ page }) =&gt; {<br>    <span>await</span> page.route(<span>'**/*'</span>, (route) =&gt; {<br>        <span>if</span> (route.request().url().includes(<span>'ads'</span>)) {<br>            route.abort();<br>        } <span>else</span> {<br>            route.<span>continue</span>();<br>        }<br>    });<br>    <span>await</span> page.goto(<span>'https://example.com'</span>);<br>    <span>await</span> expect(page.locator(<span>'[data-testid="ad-banner"]'</span>)).not.toBeVisible();<br>});</span>
```

## 110\. Capture Full Page Screenshots for Regression

Take **full-page screenshots** to compare UI regressions over time.Example: Full Page Screenshot for Regression

```
<span id="2d4a" data-selectable-paragraph="">test(<span>'Full page screenshot for regression testing'</span>, <span>async</span> ({ page }) =&gt; {<br>    <span>await</span> page.<span>goto</span>(<span>'https://example.com'</span>);<br>    <span>await</span> page.screenshot({ path: <span>'fullpage.png'</span>, fullPage: <span>true</span> });<br>})</span>
```

## 113\. Headless Device Emulation(Mobile Testing)

Test **mobile web apps** using Playwright’s built-in device emulation. Example: Mobile Emulation

```
<span id="7de9" data-selectable-paragraph="">test.use({<br>    viewport: { width: <span>375</span>, height: <span>667</span> },<br>    userAgent: <span>'Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_1 like Mac OS X) AppleWebKit/537.51.1 (KHTML, like Gecko) Version/10.0 Mobile/14E304 Safari/602.1'</span>,<br>});<br>test(<span>'Test mobile experience'</span>, <span>async</span> ({ page }) =&gt; {<br>    <span>await</span> page.<span>goto</span>(<span>'https://example.com'</span>);<br>    <span>await</span> expect(page.locator(<span>'[data-testid="mobile-nav"]'</span>)).toBeVisible();<br>});</span>
```

## 128\. Capture Console Logs During Test

Capture browser console logs and assert that they do not contain **errors**. Example: Capture Console Errors

```
<span id="b73b" data-selectable-paragraph="">test(<span>'Capture console errors'</span>, <span>async</span> ({ page }) =&gt; {<br>    <span>const</span> consoleErrors = [];<br>    <br>    page.<span>on</span>(<span>'console'</span>, (msg) =&gt; {<br>        <span>if</span> (msg.type() === <span>'error'</span>) {<br>            consoleErrors.push(msg.text());<br>        }<br>    });<br>    <br>    <span>await</span> page.goto(<span>'https://example.com'</span>);<br>    <span>await</span> page.click(<span>'[data-testid="button-causing-error"]'</span>);<br>    <br>    expect(consoleErrors.length).toBe(<span>0</span>);  <br>});</span>
```

## 129\. Cross-browser Performance Testing

Compare **performance metrics** like page load times across different browsers. Example: Cross-Browser Performance Test

```
<span id="5cb4" data-selectable-paragraph=""><span>test</span>(<span>'Compare page load performance in multiple browsers'</span>, <span>async</span> ({ page, browserName }) =&gt; {<br>    <span>const</span> startTime = <span>Date</span>.<span>now</span>();<br>    <span>await</span> page.<span>goto</span>(<span>'https://example.com'</span>);<br>    <span>const</span> loadTime = <span>Date</span>.<span>now</span>() - startTime;<br>    <br>    <span>if</span> (browserName === <span>'chromium'</span>) {<br>        <span>console</span>.<span>log</span>(<span>`Chromium load time: <span>${loadTime}</span> ms`</span>);<br>    } <span>else</span> <span>if</span> (browserName === <span>'firefox'</span>) {<br>        <span>console</span>.<span>log</span>(<span>`Firefox load time: <span>${loadTime}</span> ms`</span>);<br>    }<br>    <br>    <span>expect</span>(loadTime).<span>toBeLessThan</span>(<span>3000</span>);  <br>});</span>
```

## 137\. Test Web Workers

Test how your app interacts with **web workers** or **background scripts**. Example: Test Web Worker Interaction

```
<span id="4476" data-selectable-paragraph=""><span>test</span>(<span>'Test web workers'</span>, <span>async</span> ({ page }) =&gt; {<br>    <span>await</span> page.<span>goto</span>(<span>'https://example.com'</span>);<br>    <br>    <span>const</span> workerResponse = <span>await</span> page.evaluate(<span>() =&gt;</span> {<br>        <span>return</span> <span>new</span> <span>Promise</span>(<span>(<span>resolve</span>) =&gt;</span> {<br>            <span>const</span> worker = <span>new</span> <span>Worker</span>(<span>'worker.js'</span>);<br>            worker.<span>postMessage</span>(<span>'Hello'</span>);<br>            worker.<span>onmessage</span> = <span>(<span>event</span>) =&gt;</span> <span>resolve</span>(event.<span>data</span>);<br>        });<br>    });<br><span>expect</span>(workerResponse).<span>toBe</span>(<span>'Hello from worker'</span>);<br>});</span>
```

## 139\. Testing for Data-Driven Applications

Test your app’s **data handling** using **large datasets** and **data-bound elements**.Example: Test Data-driven App with Large Dataset

```
<span id="387d" data-selectable-paragraph="">test(<span>'Test data-driven application'</span>, <span>async</span> ({ page }) =&gt; {<br>    <span>await</span> page.<span>goto</span>(<span>'https://example.com/data-table'</span>);<br>    <br>    <span>const</span> rowCount = <span>await</span> page.locator(<span>'table tbody tr'</span>).count();<br>    expect(rowCount).toBeGreaterThan(<span>100</span>);  <br><span>const</span> firstRow = <span>await</span> page.locator(<span>'table tbody tr:first-child td'</span>).textContent();<br>    expect(firstRow).toContain(‘Expected Data’); });<br>✅ **Why?**  <br>- Validates that **large datasets** are handled efficiently <span>and</span> displayed correctly. <br>--<br><span>## **140. Advanced Error Handling: Test Retry Logic**</span><br>Handle flaky tests <span>and</span> ensure that errors are captured <span>and</span> retried appropriately.<br><span>### **Example: Retry on Failure**</span><br>```javascript</span>
```

## 141\. Use Playwright’s Test Fixtures for Reusable Setup

Playwright’s **fixtures** can be used to provide a reusable test setup for all your tests, such as creating pages, contexts, or any custom setup logic. Example: Custom Test Fixture

```
<span id="6a2b" data-selectable-paragraph="">import { test <span>as</span> <span>base</span>, expect } <span>from</span> <span>'@playwright/test'</span>;<br><span>const</span> test = <span>base</span>.extend({<br>  customPage: <span>async</span> ({ page }, use) =&gt; {<br>    <span>await</span> page.<span>goto</span>(<span>'https://example.com'</span>);<br>    <span>await</span> use(page);<br>  },<br>});test(<span>'Test with custom fixture'</span>, <span>async</span> ({ customPage }) =&gt; {<br>  <span>await</span> customPage.click(<span>'[data-testid="some-button"]'</span>);<br>  <span>await</span> expect(customPage.locator(<span>'[data-testid="result"]'</span>)).toHaveText(<span>'Success'</span>);<br>});</span>
```

## 144\. Test API and UI Consistency Together

Ensure that UI updates align with API responses by integrating **API requests** and **UI checks**.Example: Test UI and API Consistency

```
<span id="3a48" data-selectable-paragraph="">test(<span>'Test UI matches API response'</span>, <span>async</span> ({ page }) =&gt; {<br>  <span>const</span> apiResponse = <span>await</span> page.request.<span>get</span>(<span>'https://api.example.com/data'</span>);<br>  <span>const</span> apiData = <span>await</span> apiResponse.json();<br>  <br>  <span>await</span> page.<span>goto</span>(<span>'https://example.com'</span>);<br>  <span>const</span> uiElement = page.locator(<span>'[data-testid="data-element"]'</span>);<br>  <span>await</span> expect(uiElement).toHaveText(apiData.someText);<br>});</span>
```

## 145\. Record and Share Videos of Tests

Playwright has built-in support for **recording videos** of test runs, which is useful for debugging and sharing results with teammates.Example: Record Test Video

```
<span id="4321" data-selectable-paragraph="">test(<span>'Record video of test'</span>, <span>async</span> ({ page, context }) =&gt; {<br>  <span>const</span> videoPath = <span>'videos/test-video.mp4'</span>;<br>  <span>const</span> contextWithVideo = <span>await</span> browser.newContext({<br>    recordVideo: { dir: <span>'videos/'</span> }<br>  });<br>  <br>  <span>const</span> pageWithVideo = <span>await</span> contextWithVideo.newPage();<br>  <span>await</span> pageWithVideo.<span>goto</span>(<span>'https://example.com'</span>);<br>  <span>await</span> pageWithVideo.click(<span>'[data-testid="button"]'</span>);<br>  <span>await</span> expect(pageWithVideo.locator(<span>'[data-testid="success-message"]'</span>)).toBeVisible();<br>  <span>await</span> pageWithVideo.close();  <br>});</span>
```

## 146\. Test for Application Internationalization (i18n)

Test the application’s **multi-language support** by simulating different language environments. Example: Test for i18n

```
<span id="fe31" data-selectable-paragraph="">test(<span>'Test with French language'</span>, <span>async</span> ({ page }) =&gt; {<br>  <span>await</span> page.<span>goto</span>(<span>'https://example.com'</span>);<br>  <span>await</span> page.click(<span>'[data-testid="language-selector"]'</span>);<br>  <span>await</span> page.click(<span>'[data-testid="french-language-option"]'</span>);<br>  <br>  <span>await</span> expect(page.locator(<span>'[data-testid="welcome-message"]'</span>)).toHaveText(<span>'Bienvenue'</span>);<br>});</span>
```

## 147\. Automatically Retry Flaky Tests

Playwright allows you to easily retry tests when they fail, which is useful for handling **flaky tests** that occasionally fail.

## Example: Retry Logic

```
<span id="4e33" data-selectable-paragraph="">test(<span>'Test with retry on failure'</span>, <span>async</span> ({ page }) =&gt; {<br>  test.retry(<span>2</span>); <br>  <span>await</span> page.<span>goto</span>(<span>'https://example.com'</span>);<br>  <span>await</span> page.click(<span>'[data-testid="button-causing-flaky-error"]'</span>);<br>  <span>await</span> expect(page.locator(<span>'[data-testid="result"]'</span>)).toHaveText(<span>'Success'</span>);<br>});</span>
```

## 148\. Test for Security Vulnerabilities

Check for **common security vulnerabilities** in your web application using Playwright’s capabilities. Example: Test for Mixed Content

```
<span id="9dea" data-selectable-paragraph=""><span>test</span>(<span>'Test</span> <span>for</span> <span>mixed</span> content', <span>async</span> ({ page }) =&gt; {<br>  <span>await</span> page.<span>goto</span>(<span>'https</span>:<br>  <span>const</span> mixedContent = <span>await</span> page.<span>locator</span>(<span>'img</span>[src^=<span>"http://"</span>]').<span>count</span>();<br>  <br>  <span>expect</span>(mixedContent).<span>toBe</span>(<span>0</span>); <br>});</span>
```

## 151\. Test Web Accessibility (a11y)

Ensure your web application is **accessible** by using Playwright to automate accessibility tests and verify that it meets WCAG guidelines. Example: Test Accessibility with Axe-core

```
<span id="2d68" data-selectable-paragraph=""><span>import</span> { test, expect } <span>from</span> <span>'@playwright/test'</span>;<br><span>import</span> { injectAxe, checkA11y } <span>from</span> <span>'axe-playwright'</span>;<br><span>test</span>(<span>'Test for Web Accessibility'</span>, <span>async</span> ({ page }) =&gt; {<br>  <span>await</span> page.<span>goto</span>(<span>'https://example.com'</span>);<br>  <br>  <br>  <span>await</span> <span>injectAxe</span>(page);<br>  <span>await</span> <span>checkA11y</span>(page, <span>null</span>, {<br>    <span>detailedReport</span>: <span>true</span>,<br>    <span>detailedReportOptions</span>: { <span>html</span>: <span>true</span> }<br>  });<br>});<br><br>including those <span>with</span> disabilities, and helps you meet accessibility standards.</span>
```

## 152\. Test Performance on Low-End Devices

Test the performance of your web app under **lower-end device conditions** to ensure it works well even on **resource-constrained devices**.Example: Test on a Low-End Device (Simulated)

```
<span id="0688" data-selectable-paragraph="">test.<span>use</span>({<br>  <span>viewport</span>: { <span>width</span>: <span>320</span>, <span>height</span>: <span>480</span> },  <br>  <span>deviceScaleFactor</span>: <span>2</span>,  <br>});<br><span>test</span>(<span>'Test on low-end device'</span>, <span>async</span> ({ page }) =&gt; {<br>  <span>await</span> page.<span>goto</span>(<span>'https://example.com'</span>);<br>  <span>const</span> startTime = <span>Date</span>.<span>now</span>();<br>  <span>await</span> page.<span>reload</span>();<br>  <span>const</span> loadTime = <span>Date</span>.<span>now</span>() - startTime;<br>  <span>console</span>.<span>log</span>(<span>`Page loaded in <span>${loadTime}</span> ms on low-end device`</span>);<br>  <span>expect</span>(loadTime).<span>toBeLessThan</span>(<span>5000</span>);  <br>});</span>
```

## 153\. Handle Complex Modal Windows

Test **complex modal dialogs** that may contain dynamic content, form elements, and require user interaction.

## Example: Test Dynamic Modal

```
<span id="f91e" data-selectable-paragraph="">test(<span>'Test dynamic modal window'</span>, <span>async</span> ({ page }) =&gt; {<br>  <span>await</span> page.<span>goto</span>(<span>'https://example.com'</span>);<br>  <span>await</span> page.click(<span>'[data-testid="open-modal-button"]'</span>);<br>  <br>  <span>const</span> modal = page.locator(<span>'[data-testid="modal"]'</span>);<br>  <span>await</span> expect(modal).toBeVisible();<br>  <br>  <span>await</span> modal.fill(<span>'[data-testid="username"]'</span>, <span>'testuser'</span>);<br>  <span>await</span> modal.fill(<span>'[data-testid="password"]'</span>, <span>'password123'</span>);<br>  <span>await</span> modal.click(<span>'[data-testid="submit-button"]'</span>);<br>  <br>  <span>await</span> expect(modal.locator(<span>'[data-testid="success-message"]'</span>)).toBeVisible();<br>});</span>
```

## 154\. Test for Application Scalability

Test your application’s ability to **scale** under load by simulating multiple users or requests in parallel.

## Example: Simulate Load with Multiple Parallel Users

```
<span id="35ae" data-selectable-paragraph="">test(<span>'Test for scalability with multiple users'</span>, <span>async</span> ({ browser }) =&gt; {<br>  <span>const</span> numUsers = <span>10</span>;<br>  <span>const</span> promises = [];<br>  <br>  <span>for</span> (<span>let</span> i = <span>0</span>; i &lt; numUsers; i++) {<br>    <span>const</span> context = <span>await</span> browser.newContext();<br>    <span>const</span> page = <span>await</span> context.newPage();<br>    promises.push(page.<span>goto</span>(<span>'https://example.com'</span>));<br>  }<br>  <br>  <span>await</span> Promise.all(promises);  <br>});</span>
```

## 156\. Test for SEO-Friendly URLs

Ensure that URLs in your application are **SEO-friendly** and follow best practices for search engine optimization.s

```
<span id="10f4" data-selectable-paragraph="">test(<span>'Test SEO-friendly URLs'</span>, <span>async</span> ({ page }) =&gt; {<br>  <span>await</span> page.<span>goto</span>(<span>'https://example.com'</span>);<br>  <br>  <span>const</span> currentUrl = <span>await</span> page.url();<br>  expect(currentUrl).toMatch(/\/[a-z0<span>-9</span>-]+/);  <br>});<br>test(<span>'Test SEO meta tags'</span>, <span>async</span> ({ page }) =&gt; {<br>    <span>await</span> page.<span>goto</span>(<span>'https://example.com'</span>);<br>    <span>const</span> title = <span>await</span> page.title();<br>    <span>const</span> description = <span>await</span> page.locator(<span>'meta[name="description"]'</span>).getAttribute(<span>'content'</span>);<br>    <br>    expect(title).toBe(<span>'Expected Title'</span>);<br>    expect(description).toContain(<span>'Expected description for SEO'</span>);<br>});</span>
```

## 159\. Test API Rate Limiting

Ensure that your API enforces **rate limiting** and prevents abuse from too many requests.

```
<span id="87f9" data-selectable-paragraph="">test(<span>'Test API rate limiting'</span>, <span>async</span> ({ page }) =&gt; {<br>  <span>const</span> apiEndpoint = <span>'https://example.com/api/limited-resource'</span>;<br>  <br>  <span>const</span> responses = [];<br>  <span>for</span> (<span>let</span> i = <span>0</span>; i &lt; <span>10</span>; i++) {<br>    responses.push(page.request.<span>get</span>(apiEndpoint));<br>  }<br><span>const</span> results = <span>await</span> Promise.all(responses);<br>  <br>  <br>  <span>for</span> (<span>let</span> i = <span>5</span>; i &lt; results.length; i++) {<br>    expect(results[i].status()).toBe(<span>429</span>);  <br>  }<br>});</span>
```

## 163\. Test Offline Functionality

Ensure your app works **offline** or in **low-connectivity environments**.Example: Test Offline Mode

```
<span id="4ef0" data-selectable-paragraph="">test(<span>'Test offline functionality'</span>, <span>async</span> ({ page, browserContext }) =&gt; {<br>  <br>  <span>await</span> browserContext.setOffline(<span>true</span>);<br>  <br>  <span>await</span> page.<span>goto</span>(<span>'https://example.com'</span>);<br>  <span>await</span> page.click(<span>'[data-testid="offline-action-button"]'</span>);<br>  <br>  <br>  <span>await</span> expect(page.locator(<span>'[data-testid="offline-message"]'</span>)).toBeVisible();<br>  <br>  <br>  <span>await</span> browserContext.setOffline(<span>false</span>);<br>});</span>
```

## 164\. Test Cookie Handling and Session Persistence

Test how your app handles **cookies** and maintains **session persistence** across multiple interactions.

## Example: Test Cookie Handling

```
<span id="1007" data-selectable-paragraph="">test(<span>'Test cookie handling and session persistence'</span>, <span>async</span> ({ page }) =&gt; {<br>  <span>await</span> page.<span>goto</span>(<span>'https://example.com'</span>);<br>  <br>  <br>  <span>await</span> page.context().addCookies([{ name: <span>'session'</span>, <span>value</span>: <span>'12345'</span>, url: <span>'https://example.com'</span> }]);<br>  <br>  <br>  <span>const</span> cookies = <span>await</span> page.context().cookies();<br>  expect(cookies).toContainEqual(expect.objectContaining({ name: <span>'session'</span> }));<br>  <br>  <br>  <span>await</span> page.reload();<br>  <span>await</span> expect(page.locator(<span>'[data-testid="logged-in"]'</span>)).toBeVisible();<br>});</span>
```

## 165\. Test Responsive Design

Validate the **responsiveness** of your website by simulating different screen sizes and ensuring UI elements adapt correctly.Example: Test Responsive Layouts

```
<span id="95e5" data-selectable-paragraph=""><span>test</span>(<span>'Test responsive design'</span>, <span>async</span> ({ page }) =&gt; {<br>  <br>  <span>await</span> page.<span>setViewportSize</span>({ <span>width</span>: <span>320</span>, <span>height</span>: <span>480</span> });<br>  <span>await</span> page.<span>goto</span>(<span>'https://example.com'</span>);<br>  <span>await</span> <span>expect</span>(page.<span>locator</span>(<span>'[data-testid="mobile-navbar"]'</span>)).<span>toBeVisible</span>();<br>  <br>  <br>  <span>await</span> page.<span>setViewportSize</span>({ <span>width</span>: <span>1440</span>, <span>height</span>: <span>900</span> });<br>  <span>await</span> <span>expect</span>(page.<span>locator</span>(<span>'[data-testid="desktop-navbar"]'</span>)).<span>toBeVisible</span>();<br>});<br><span>test</span>(<span>'Mobile performance test'</span>, <span>async</span> ({ page }) =&gt; {<br>    <span>const</span> startTime = <span>Date</span>.<span>now</span>();<br>    <span>await</span> page.<span>goto</span>(<span>'https://example.com'</span>);<br>    <span>const</span> loadTime = <span>Date</span>.<span>now</span>() - startTime;<br>    <br>    <span>console</span>.<span>log</span>(<span>`Mobile load time: <span>${loadTime}</span> ms`</span>);<br>    <span>expect</span>(loadTime).<span>toBeLessThan</span>(<span>3000</span>);  <br>});</span>
```

## 166\. Test Animations and Transitions

Verify that UI **animations and transitions** work smoothly and enhance user experience.Example: Test Smooth Animation

```
<span id="e5c1" data-selectable-paragraph=""><span>test</span>(<span>'Test smooth animation'</span>, <span>async</span> ({ page }) =&gt; {<br>  <span>await</span> page.<span>goto</span>(<span>'https://example.com'</span>);<br>  <br>  <br>  <span>await</span> page.<span>click</span>(<span>'[data-testid="animate-button"]'</span>);<br>  <br>  <span>const</span> element = page.<span>locator</span>(<span>'[data-testid="animated-element"]'</span>);<br>  <br>  <br>  <span>await</span> <span>expect</span>(element).<span>toHaveClass</span>(<span>/animated/</span>);<br>  <span>await</span> <span>expect</span>(element).<span>toHaveStyle</span>({ <span>transform</span>: <span>'translateX(100px)'</span> });<br>});</span>
```

## 167\. Test for Dynamic Content Loading (Lazy Loading)

Automate tests for **lazy loading** of content (e.g., images, videos, or data) to ensure that content loads efficiently without blocking the UI.Example: Test Lazy Loading

```
<span id="5f8a" data-selectable-paragraph="">test(<span>'Test lazy loading of images'</span>, <span>async</span> ({ page }) =&gt; {<br>  <span>await</span> page.<span>goto</span>(<span>'https://example.com'</span>);<br>  <br>  <span>const</span> image = page.locator(<span>'[data-testid="lazy-loaded-image"]'</span>);<br>  <br>  <br>  <span>await</span> expect(image).toBeHidden();<br>  <br>  <br>  <span>await</span> page.scrollIntoViewIfNeeded(image);<br>  <br>  <br>  <span>await</span> expect(image).toBeVisible();<br>});</span>
```

## 168\. Test Web App Localization

Ensure that your web app functions correctly when localized for **different languages** and **regions**.Example: Test App Localization

```
<span id="6478" data-selectable-paragraph="">test(<span>'Test localization for different languages'</span>, <span>async</span> ({ page }) =&gt; {<br>  <span>await</span> page.<span>goto</span>(<span>'https://example.com'</span>);<br>  <br>  <br>  <span>await</span> page.click(<span>'[data-testid="language-selector"]'</span>);<br>  <span>await</span> page.click(<span>'[data-testid="french-option"]'</span>);<br>  <br>  <br>  <span>await</span> expect(page.locator(<span>'[data-testid="welcome-text"]'</span>)).toHaveText(<span>'Bienvenue'</span>);<br>});</span>
```

## 169\. Test for Cross-Browser Compatibility

Ensure your web app works across different browsers by running tests in multiple browser contexts (e.g., Chromium, Firefox, WebKit).Example: Test Cross-Browser Compatibility

```
<span id="54f1" data-selectable-paragraph=""><span>test</span>(<span>'Test cross-browser compatibility'</span>, <span>async</span> ({ page, browserName }) =&gt; {<br>  <span>console</span>.<span>log</span>(<span>`Running test in <span>${browserName}</span>`</span>);<br>  <br>  <span>await</span> page.<span>goto</span>(<span>'https://example.com'</span>);<br>  <span>await</span> <span>expect</span>(page.<span>locator</span>(<span>'[data-testid="app-header"]'</span>)).<span>toBeVisible</span>();<br>});</span>
```

## 170\. Test Dark Mode

Verify that your app supports **dark mode** and displays UI elements correctly in this mode. Example: Test Dark Mode

```
<span id="939a" data-selectable-paragraph="">test(<span>'Test dark mode'</span>, <span>async</span> ({ page }) =&gt; {<br>  <span>await</span> page.<span>goto</span>(<span>'https://example.com'</span>);<br>  <br>  <br>  <span>await</span> page.click(<span>'[data-testid="dark-mode-toggle"]'</span>);<br>  <br>  <br>  <span>await</span> expect(page.locator(<span>'[data-testid="background"]'</span>)).toHaveClass(<span>'dark-mode'</span>);<br>  <span>await</span> expect(page.locator(<span>'[data-testid="header"]'</span>)).toHaveCSS(<span>'color'</span>, <span>'rgb(255, 255, 255)'</span>);<br>});</span>
```

## 171\. Test for Memory Leaks in Single Page Applications (SPA)

Memory leaks in SPAs can degrade performance over time. You can monitor **JavaScript heap usage** to detect potential leaks.

## Example: Track Memory Usage

```
<span id="1829" data-selectable-paragraph=""><span>test</span>(<span>'Detect memory leaks in SPA'</span>, <span>async</span> ({ page }) =&gt; {<br>  <span>await</span> page.<span>goto</span>(<span>'https://example.com/spa'</span>);<br>  <br>  <span>const</span> initialHeapSize = (<span>await</span> page.evaluate(<span>() =&gt;</span> performance.<span>memory</span>.<span>usedJSHeapSize</span>)) / <span>1024</span> / <span>1024</span>;<br>  <br>  <span>for</span> (<span>let</span> i = <span>0</span>; i &lt; <span>10</span>; i++) {<br>    <span>await</span> page.<span>click</span>(<span>'[data-testid="navigate-button"]'</span>); <br>    <span>await</span> page.<span>waitForTimeout</span>(<span>500</span>);<br>  }<br>  <br>  <span>const</span> finalHeapSize = (<span>await</span> page.evaluate(<span>() =&gt;</span> performance.<span>memory</span>.<span>usedJSHeapSize</span>)) / <span>1024</span> / <span>1024</span>;<br>  <br>  <span>console</span>.<span>log</span>(<span>`Memory Usage: Initial <span>${initialHeapSize}</span>MB -&gt; Final <span>${finalHeapSize}</span>MB`</span>);<br>  <span>expect</span>(finalHeapSize).<span>toBeLessThan</span>(initialHeapSize * <span>1.5</span>); <br>});</span>
```

## 172\. Simulate User Rage Clicks

Some users rapidly click when frustrated. Test whether your app can handle **rage clicks** gracefully.Example: Detect Rage Clicking

```
<span id="d59e" data-selectable-paragraph="">test(<span>'Handle rage clicks without breaking UI'</span>, <span>async</span> ({ page }) =&gt; {<br>  <span>await</span> page.<span>goto</span>(<span>'https://example.com'</span>);<br>  <br>  <span>for</span> (<span>let</span> i = <span>0</span>; i &lt; <span>20</span>; i++) {<br>    <span>await</span> page.click(<span>'[data-testid="button"]'</span>, { delay: <span>50</span> });<br>  }<br>  <br>  <br>  <span>await</span> expect(page.locator(<span>'[data-testid="confirmation"]'</span>)).toBeVisible();<br>});</span>
```

## 175\. Test Smart Auto-Complete and Suggestions

Ensure that **auto-suggestions** appear and behave correctly when users type into an input field. Example: Validate Auto-Complete Functionality

```
<span id="94df" data-selectable-paragraph=""><span>test</span>(<span>'Validate auto-suggestions'</span>, <span>async</span> ({ page }) =&gt; {<br>  <span>await</span> page.<span>goto</span>(<span>'https://example.com/search'</span>);<br>  <br>  <span>await</span> page.<span>fill</span>(<span>'[data-testid="search-box"]'</span>, <span>'play'</span>);<br>  <span>await</span> <span>expect</span>(page.<span>locator</span>(<span>'[data-testid="suggestion-list"]'</span>)).<span>toBeVisible</span>();<br>  <span>await</span> <span>expect</span>(page.<span>locator</span>(<span>'[data-testid="suggestion-item"]'</span>).<span>first</span>()).<span>toHaveText</span>(<span>/playwright/i</span>);<br>});</span>
```

## 177\. Test WebRTC (Video/Audio Calls)

Automate testing for **video/audio calls** using WebRTC.Example: Test WebRTC Connection

```
<span id="e991" data-selectable-paragraph="">test(<span>'Test WebRTC call'</span>, <span>async</span> ({ page }) =&gt; {<br>  <span>await</span> page.<span>goto</span>(<span>'https://example.com/video-call'</span>);<br><br>  <span>await</span> page.context().grantPermissions([<span>'camera'</span>, <span>'microphone'</span>]);<br>  <span>await</span> page.click(<span>'[data-testid="start-call"]'</span>);<br>  <span>await</span> expect(page.locator(<span>'[data-testid="video-stream"]'</span>)).toBeVisible();<br>});</span>
```

## 179\. Test Database-Driven UI Updates

Simulate **database changes** and validate if the UI updates accordingly. Example: Validate UI Reflects Database Changes

```
<span id="da44" data-selectable-paragraph="">test(<span>'Verify UI updates when database changes'</span>, <span>async</span> ({ page }) =&gt; {<br>  <span>await</span> page.<span>goto</span>(<span>'https://example.com/admin'</span>);<br>  <br>  <br>  <span>await</span> fetch(<span>'https://example.com/api/update-data'</span>, { method: <span>'POST'</span> });<br> <br>  <span>await</span> page.reload();<br>  <span>await</span> expect(page.locator(<span>'[data-testid="updated-value"]'</span>)).<br>  toHaveText(<span>'New Data'</span>);<br>});</span>
```

## 180\. Test Multi-Tenant Applications

If your app supports **multiple organizations/users**, ensure correct tenant isolation.Example: Validate Multi-Tenancy

```
<span id="6426" data-selectable-paragraph="">test(<span>'Test multi-tenant isolation'</span>, <span>async</span> ({ page }) =&gt; {<br>  <span>await</span> page.<span>goto</span>(<span>'https://example.com?tenant=org1'</span>);<br>  <span>await</span> expect(page.locator(<span>'[data-testid="tenant-name"]'</span>)).toHaveText(<span>'Organization 1'</span>);<br>  <span>await</span> page.<span>goto</span>(<span>'https://example.com?tenant=org2'</span>);<br>  <span>await</span> expect(page.locator(<span>'[data-testid="tenant-name"]'</span>)).toHaveText(<span>'Organization 2'</span>);<br>});</span>
```

## 182\. Test Augmented Reality (AR) and Virtual Reality (VR) UI

Web-based **AR/VR applications** require specific UI interactions and permission handling.Example: Test WebXR AR Mode

```
<span id="3faf" data-selectable-paragraph="">test(<span>'Test AR mode activation'</span>, <span>async</span> ({ page }) =&gt; {<br>  <span>await</span> page.<span>goto</span>(<span>'https://example.com/ar-experience'</span>);<br>  <span>await</span> page.context().grantPermissions([<span>'xr-spatial-tracking'</span>]);<br>  <span>await</span> page.click(<span>'[data-testid="start-ar"]'</span>);<br>  <span>await</span> expect(page.locator(<span>'[data-testid="ar-view"]'</span>)).toBeVisible();<br>});</span>
```

## 184\. Test AI-Generated Content in UI (Chatbots, LLMs)

Apps that integrate **AI-generated responses (like chatbots or LLMs)** should be tested for responsiveness and accuracy. Example: Verify Chatbot AI Response

```
<span id="542f" data-selectable-paragraph=""><span>test</span>(<span>'Test AI chatbot response'</span>, <span>async</span> ({ page }) =&gt; {<br>  <span>await</span> page.<span>goto</span>(<span>'https://example.com/chatbot'</span>);<br>  <span>await</span> page.<span>fill</span>(<span>'[data-testid="chat-input"]'</span>, <span>'Hello, bot!'</span>);<br>  <span>await</span> page.<span>press</span>(<span>'[data-testid="chat-input"]'</span>, <span>'Enter'</span>);<br>  <span>await</span> <span>expect</span>(page.<span>locator</span>(<span>'[data-testid="chat-response"]'</span>)).<span>toContainText</span>(<span>/Hello/i</span>);<br>});</span>
```

## 190\. Test Device Rotation Handling

Ensure your app adapts to **screen rotation**. Example: Simulate Device Rotation

```
<span id="65c7" data-selectable-paragraph="">test(<span>'Test device orientation change'</span>, <span>async</span> ({ page }) =&gt; {<br>  <span>await</span> page.<span>goto</span>(<span>'https://example.com'</span>);<br>  <span>await</span> page.setViewportSize({ width: <span>1080</span>, height: <span>1920</span> });<br>  <span>await</span> expect(page.locator(<span>'[data-testid="mobile-layout"]'</span>)).toBeVisible();<br>  <span>await</span> page.setViewportSize({ width: <span>1920</span>, height: <span>1080</span> });<br>  <span>await</span> expect(page.locator(<span>'[data-testid="desktop-layout"]'</span>)).toBeVisible();<br>});</span>
```
