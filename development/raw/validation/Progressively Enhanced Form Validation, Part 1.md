---
created: 2024-09-24T13:17:11 (UTC -04:00)
tags: []
source: https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-1-html-and-css/
author: Gerardo Rodriguez
---

# Progressively Enhanced Form Validation, Part 1: HTML and CSS – Cloud Four

> ## Excerpt
> Browsers nowadays have built-in form validation features that make JavaScript-only solutions unnecessary. Let's explore what this might look like using progressive enhancement techniques.

---
Browsers nowadays have built-in form validation (or “constraint validation”) features that are super helpful for highlighting when the entered data satisfies the necessary criteria. Some of us have relied on JavaScript-only solutions to handle client-side form validation in the past (`/me` slowly raises hand…), but as it turns out, most of these built-in features have been around for [over a decade](https://web.dev/constraintvalidation/)!

> [HTML5](https://developer.mozilla.org/en-US/docs/Glossary/HTML5) introduced new mechanisms for forms: it added new semantic types for the [`<input>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input) element and _constraint validation_ to ease the work of checking the form content on the client side. Basic, usual constraints can be checked, without the need for JavaScript, by setting new attributes; more complex constraints can be tested using the Constraint Validation API.
> 
> [MDN Constraint Validation docs](https://developer.mozilla.org/en-US/docs/Web/HTML/Constraint_validation)

Join along as we explore progressively enhancing the form validation experience through a series of articles. Starting with the browser’s built-in validation features using HTML and CSS, then layering JavaScript for more enhancements, each successive article will build on the previous.

Feel free to view [this article’s accompanying demo](https://constraint-validation-api-demo.netlify.app/part-1/) as a reference. The [source code is available on GitHub](https://github.com/cloudfour/constraint-validation-api-demo).

I’m excited and hope you are too. Let’s dive into the foundation of any website: HTML and CSS.

[Permalink to Browser built-in form validation as the foundation](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-1-html-and-css/#browser-built-in-form-validation-as-the-foundation)

## Browser built-in form validation as the foundation

[Native form validation](https://developer.mozilla.org/en-US/docs/Learn/Forms/Form_validation#using_built-in_form_validation) features can validate most user data without relying on JavaScript. These features provide the strong foundation required for building a progressively enhanced experience.

Let’s take a closer look at each feature.

[Permalink to Input `type` attributes](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-1-html-and-css/#input-type-attributes)

### Input `type` attributes

It starts with choosing the most semantically appropriate value for the [`input` `type` attribute](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input#type) (e.g., `type="email"`).

```
<span><code id="code-lang-xml"><span><span><span>&lt;<span>label</span> <span>for</span>=<span>"customer-email"</span>&gt;</span>Email<span>&lt;/<span>label</span>&gt;</span>
</span></span><span><span><span>&lt;<span>input</span></span>
</span></span><span><span><span>  <span>id</span>=<span>"customer-email"</span></span>
</span></span><span><span><span>  <span>name</span>=<span>"customerEmail"</span></span>
</span></span><mark><span><span>  <span>type</span>=<span>"email"</span></span>
</span></mark><span><span><span>/&gt;</span>
</span></span></code></span><small id="shcb-language-1"><span>Code language:</span> <span>HTML, XML</span> <span>(</span><span>xml</span><span>)</span></small>
```

Other [validation attributes](https://developer.mozilla.org/en-US/docs/Web/HTML/Constraint_validation#validation-related_attributes) can be added to layer more constraints (e.g., `[required](https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/required)`, `[min](https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/min)`/`[max](https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/max)`, `[minlength](https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/minlength)`/`[maxlength](https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/maxlength)`, `[pattern](https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/pattern)`, etc.).

```
<span><code id="code-lang-xml"><span><span><span>&lt;<span>label</span> <span>for</span>=<span>"customer-email"</span>&gt;</span>
</span></span><span><span>  Email <span>&lt;<span>span</span> <span>aria-hidden</span>=<span>"true"</span>&gt;</span>(required)<span>&lt;/<span>span</span>&gt;</span>
</span></span><span><span><span>&lt;/<span>label</span>&gt;</span>
</span></span><span><span><span>&lt;<span>input</span></span>
</span></span><span><span><span>  <span>id</span>=<span>"customer-email"</span></span>
</span></span><span><span><span>  <span>name</span>=<span>"customerEmail"</span></span>
</span></span><span><span><span>  <span>type</span>=<span>"email"</span></span>
</span></span><mark><span><span>  <span>required</span></span>
</span></mark><mark><span><span>  <span>minlength</span>=<span>"2"</span></span>
</span></mark><span><span><span>/&gt;</span>
</span></span></code></span><small id="shcb-language-2"><span>Code language:</span> <span>HTML, XML</span> <span>(</span><span>xml</span><span>)</span></small>
```

[Permalink to CSS pseudo-classes](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-1-html-and-css/#css-pseudo-classes)

### CSS pseudo-classes

[Value-checking pseudo-classes](https://drafts.csswg.org/selectors-4/#ui-validity) are available to help style form controls. Depending on your site’s design, you may not need all of them, but it’s good to know they exist.

[Permalink to Validity pseudo-classes](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-1-html-and-css/#validity-pseudo-classes)

#### Validity pseudo-classes

To highlight valid or invalid fields.

-   `[:valid](https://developer.mozilla.org/en-US/docs/Web/CSS/:valid)`
-   `[:invalid](https://developer.mozilla.org/en-US/docs/Web/CSS/:invalid)`

[Permalink to Optionality pseudo-classes](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-1-html-and-css/#optionality-pseudo-classes)

#### Optionality pseudo-classes

To highlight required fields (specified by a `required` attribute) and optional fields (fields with no `required` attribute).

-   `` `[:required](https://developer.mozilla.org/en-US/docs/Web/CSS/:required)` ``
-   `[:optional](https://developer.mozilla.org/en-US/docs/Web/CSS/:optional)`

[Permalink to Range pseudo-classes](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-1-html-and-css/#range-pseudo-classes)

#### Range pseudo-classes

To highlight fields within or outside of the range limits specified by the field’s `min`/`max` attributes.

-   `[:in-range](https://developer.mozilla.org/en-US/docs/Web/CSS/:in-range)`
-   `[:out-of-range](https://developer.mozilla.org/en-US/docs/Web/CSS/:out-of-range)`

[Permalink to User-interaction pseudo-classes](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-1-html-and-css/#user-interaction-pseudo-classes)

#### User-interaction pseudo-classes

To highlight valid or invalid fields after the user has _interacted_ with the field.

-   `[:user-valid](https://developer.mozilla.org/en-US/docs/Web/CSS/:user-valid)`
-   [`:user-invalid`](https://developer.mozilla.org/en-US/docs/Web/CSS/:user-invalid)

[Permalink to Error message bubble](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-1-html-and-css/#error-message-bubble)

### Error message bubble

When a form is submitted, the browser automatically shows error messages in a “bubble” next to the first form control where the input data does not satisfy the form control’s validation constraints. The message and design of the bubble will differ from browser to browser. The styles of the error bubble cannot be modified, providing a consistent browser-specific user experience. However, this can also be a negative as the bubble design may not fit the site’s aesthetics.

![The Chrome browser built-in error message bubble floating over an empty email field with the message, "Please fill out this field."](https://cloudfour.com/wp-content/uploads/2023/08/Screen-Shot-2023-08-04-at-5.34.45-AM-1024x947.png)

Each browser has its own error message bubble design. Shown above is Chrome’s design.

[Permalink to How to avoid invalid styles showing on page load](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-1-html-and-css/#how-to-avoid-invalid-styles-showing-on-page-load)

## How to avoid invalid styles showing on page load

One of the pushbacks against using browser built-in form validation is that invalid styles are applied on page load before the user interacts with the form controls. I agree. This creates a confusing user experience.

![A series of required empty input fields showing the "invalid" UI state on page load.](https://cloudfour.com/wp-content/uploads/2023/08/Screen-Shot-2023-08-04-at-6.24.39-AM.png)

Seeing invalid form inputs on page load is a confusing user experience.

No worries, though, `[:user-invalid](https://developer.mozilla.org/en-US/docs/Web/CSS/:user-invalid)`/`[:user-valid](https://developer.mozilla.org/en-US/docs/Web/CSS/:user-valid)` _to the rescue!_

These CSS pseudo-classes can progressively enhance the user experience in [browsers that support them](https://caniuse.com/mdn-css_selectors_user-invalid). In contrast to `:invalid`/`:valid`, using the `:user-invalid`/`:user-valid` pseudo-classes will apply the styles only _after_ the user has interacted with the form control.

No more invalid UI styles on page load!

To support all modern browsers and apply `:user-invalid`/`:user-valid` in a progressively enhanced manner, the CSS could look something like this:

```
<span><code id="code-lang-css"><span>/**
 * For browsers that support :user-invalid/:user-valid
 */</span>
<span>input</span><span>:user-invalid</span> {
  <span>/* Invalid input UI styles */</span>
}
<span>input</span><span>:user-valid</span> {
  <span>/* Valid input UI styles */</span>
}

<span>/**
 * When not supported, fallback to :invalid/:valid
 * Wrapping :valid/:invalid in a "not" @supports block ensures 
 * that the invalid styles are not applied on page load in browsers 
 * that do support :user-invalid/:user-valid
 */</span>
<span>@supports</span> <span>not</span> selector(:user-invalid) {
  <span>input</span><span>:invalid</span> {
    <span>/* Invalid input UI styles */</span>
  }
  <span>input</span><span>:valid</span> {
    <span>/* Valid input UI styles */</span>
  }
}</code></span><small id="shcb-language-4"><span>Code language:</span> <span>CSS</span> <span>(</span><span>css</span><span>)</span></small>
```

We can see the differences when viewing the [Part 1 demo](https://constraint-validation-api-demo.netlify.app/part-1/):

-   In browsers that support `:user-invalid` (e.g., new versions of Firefox and Safari), we’ll notice invalid styles do not get applied until after we interact with and move away from (`blur`) the form control.
-   In browsers that _do not_ support `:user-invalid` (e.g., Chrome, though they are [looking to ship support soon](https://chromestatus.com/feature/5132477781245952)!), we’ll notice the invalid styles are applied when the page loads before we interact with the form controls.

[Permalink to Browser built-in validation doesn’t do everything](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-1-html-and-css/#browser-built-in-validation-doesnt-do-everything)

## Browser built-in validation doesn’t do everything

As with all things, there are always pros and cons. Let’s take a quick step back to review a few pros and cons of using browser built-in validation as the foundational base user experience.

-   No JavaScript is required!
-   No need to write custom validation logic
-   Can handle the majority of validation use cases
-   The validation errors are automatically rendered and styled by the browser providing a consistent browser-specific experience
-   Validation error messages are localized automatically

-   The error messages are not customizable (without JS)
-   The error message bubble design may not fit the overall site design
-   The `:invalid` styles are applied before the user has a chance to fill out the form field in browsers that do not support `:user-invalid`
-   Some form controls (e.g., a `checkbox` group) cannot be validated
-   [Safari has a few open `:user-invalid` related bugs](https://bugs.webkit.org/buglist.cgi?bug_status=__open__&content=%3Auser-invalid&no_redirect=1&order=Importance&query_format=specific) (three open tickets as of this article’s publish date)
-   [Web Content Accessibility Guidelines (WCAG) 2.1](https://www.w3.org/TR/WCAG21/) Success Criterion (SC) violations:
    -   [SC 1.3.1: Info and Relationships (Level A)](https://www.w3.org/WAI/WCAG21/Understanding/info-and-relationships.html) – The validation error message is not associated with the field in error
    -   [SC 1.4.4: Resize Text (Level AA)](https://www.w3.org/WAI/WCAG21/Understanding/resize-text.html) – The error message bubble text does not resize
    -   [SC 1.4.12: Text Spacing (Level AA)](https://www.w3.org/WAI/WCAG21/Understanding/text-spacing.html) – The error message bubble text does not respect text spacing styles
    -   [SC 2.2.1: Timing Adjustable (Level A)](https://www.w3.org/WAI/WCAG21/Understanding/timing-adjustable.html) – There is no control over the timing of the error message bubble, and in most cases, it disappears too quickly ([Chromium is considering closing an open issue](https://bugs.chromium.org/p/chromium/issues/detail?id=1322670#c5) that should absolutely be addressed, “star” the issue and show support!)
    -   [SC 3.3.1: Error Identification (Level A)](https://www.w3.org/WAI/WCAG21/Understanding/error-identification.html) – The field in error is not identified
    -   [SC 3.3.2: Labels or Instructions (Level A)](https://www.w3.org/WAI/WCAG21/Understanding/labels-or-instructions.html) – The reason for the error is not always clear
    -   [SC 3.3.3: Error Suggestion (Level AA)](https://www.w3.org/WAI/WCAG21/Understanding/error-suggestion.html) – The error message may not always be clear or provide a helpful suggestion

Thank you to [Juliette Alexandria](https://www.linkedin.com/in/juliette-alexandria-8946a91b0/) and [Adrian Roselli](https://adrianroselli.com/) for providing feedback and resources regarding WCAG violations for native browser validation features. Your feedback is greatly appreciated. 🙌🏽

[Permalink to Can the experience be enhanced and made more accessible?](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-1-html-and-css/#can-the-experience-be-enhanced-and-made-more-accessible)

## Can the experience be enhanced and made more accessible?

You bet it can! We can address _all_ of these cons by layering a bit of JavaScript combined with some [ARIA](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA) attributes. We can build a progressively enhanced, more accessible experience on top of the native HTML & CSS validation features.

This is a fantastic example of how progressive enhancement shines. We provide a baseline user experience without JavaScript. The enhanced version builds on an already established foundation. We no longer need to rely on _JavaScript-only_ solutions.

In the [following article of this series](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-2-layering-in-javascript/), we’ll explore all of this, building out from where the [Part 1 demo](https://constraint-validation-api-demo.netlify.app/part-1/) left off. See you there!

[Permalink to More resources](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-1-html-and-css/#more-resources)

## More resources

-   [Avoid Default Field Validation](https://adrianroselli.com/2019/02/avoid-default-field-validation.html) by Adrian Roselli
-   [MDN Web Docs: Input pseudo-classes](https://developer.mozilla.org/en-US/docs/Web/CSS/Pseudo-classes#input_pseudo-classes)

[Permalink to Missed an article in the series?](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-1-html-and-css/#missed-an-article-in-the-series)

## Missed an article in the series?

I’ve got you! Listed below are all of the articles from the series:

-   [Part 1: HTML and CSS](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-1-html-and-css/)
-   [Part 2: Layering in JavaScript](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-2-layering-in-javascript/)
-   [Part 3: Validating a checkbox group](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-3-validating-a-checkbox-group/)
-   [Part 4: Custom validation messages](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-4-custom-validation-messages/)
