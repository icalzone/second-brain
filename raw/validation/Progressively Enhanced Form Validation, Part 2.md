---
created: 2024-09-24T13:19:42 (UTC -04:00)
tags: []
source: https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-2-layering-in-javascript/
author: Gerardo Rodriguez
---

# Progressively Enhanced Form Validation, Part 2: Layering in JavaScript – Cloud Four

> ## Excerpt
> In Part 2 of this series, we take the base HTML and CSS form validation experience and progressively enhance it by adding JavaScript and the Constraint Validation API while also addressing accessibility concerns.

---
![Three icons. Icon 1: representing an invalid state, a fuscia circle shape with a white exclamation mark in the center. Icon 2: representing a valid state, a green circle shape with a white checkmark in the center. Icon 3: representing JavaScript, a yellow badge shape with brown curly brackets surrounding an ellipses in the center.](https://cloudfour.com/wp-content/uploads/2023/08/part2-1024x576.png)

In [Part 1](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-1-html-and-css/) of this series, we learned about the browser’s built-in HTML and CSS form validation features and how to use them to create a solid ([but not very accessible](https://adrianroselli.com/2019/02/avoid-default-field-validation.html)) foundation.

This article takes that [baseline experience](https://constraint-validation-api-demo.netlify.app/part-1/) and progressively enhances it by layering in [ARIA](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA) attributes, JavaScript, and the [Constraint Validation API](https://developer.mozilla.org/en-US/docs/Web/HTML/Constraint_validation).

Feel free to view [this article’s completed demo](https://constraint-validation-api-demo.netlify.app/part-2/) as a reference. The [source code is available on GitHub](https://github.com/cloudfour/constraint-validation-api-demo).

Adding JavaScript will help us display consistent error message designs, prevent invalid styles from showing prematurely for all browsers, provide live validation feedback, and create a more accessible user experience. All the [drawbacks outlined in Part 1](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-1-html-and-css/#cons) will be addressed as we explore the following:

1.  [Removing invalid styles on page load for _all_ browsers](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-2-layering-in-javascript/#removing-invalid-styles-on-page-load-for-all-browsers)
2.  [Turning off the built-in form submit validation](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-2-layering-in-javascript/#turning-off-the-built-in-form-submit-validation)
3.  [Adding event listeners for live validation](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-2-layering-in-javascript/#adding-event-listeners-for-live-validation)
4.  [Using the Constraint Validation API to validate and update the UI state](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-2-layering-in-javascript/#using-the-constraint-validation-api-to-validate-and-update-the-ui-state)
5.  [Managing the validation states for optional fields](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-2-layering-in-javascript/#managing-the-validation-states-for-optional-fields)
6.  [Handling the form `submit` event](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-2-layering-in-javascript/#handling-the-form-submit-event)
7.  [Using a custom design for validation error messages](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-2-layering-in-javascript/#using-a-custom-design-for-validation-error-messages)
8.  [Managing the validation state for sticky field values](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-2-layering-in-javascript/#managing-the-validation-state-for-sticky-field-values)
9.  [What about inputs that cannot be validated with the Constraint Validation API?](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-2-layering-in-javascript/#what-about-inputs-that-cannot-be-validated-with-the-constraint-validation-api)

Let’s jump in!

[Permalink to Removing invalid styles on page load for _all_ browsers](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-2-layering-in-javascript/#removing-invalid-styles-on-page-load-for-all-browsers)

## Removing invalid styles on page load for _all_ browsers

If we recall from [Part 1](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-1-html-and-css/#how-to-avoid-invalid-styles-showing-on-page-load), browsers not supporting the `:user-invalid`/`:user-valid` CSS pseudo-classes will render the invalid UI state prematurely. With JavaScript enabled, we can enhance the user experience to avoid this confusing UI state for _all_ browsers.

We’ll need to use all three of HTML, CSS, and JavaScript to accomplish this. First, let’s add a [data attribute](https://developer.mozilla.org/en-US/docs/Learn/HTML/Howto/Use_data_attributes) to the HTML `body` element and set it to the default non-JavaScript state:

```
<span><code id="code-lang-xml"><span>&lt;!-- 
  We're using a data attribute to represent the JS-enabled state.
  If preferred, a CSS class works as an alternative method also.
--&gt;</span>
<span>&lt;<span>body</span> <span>data-js-enabled</span>=<span>"false"</span>&gt;</span></code></span><small id="shcb-language-2"><span>Code language:</span> <span>HTML, XML</span> <span>(</span><span>xml</span><span>)</span></small>
```

Then, we can use JavaScript to update the “JS-enabled” state. Using JavaScript ensures the default non-JavaScript experience stays intact. Let’s add this logic in an `init` function as follows:

```
<span><code id="code-lang-javascript"><span><span><span>/**</span>
</span></span><span><span><span> * Initialize validation setup</span>
</span></span><span><span><span> */</span>
</span></span><span><span><span>const</span> init = <span><span>()</span> =&gt;</span> {
</span></span><span><span>  <span>// Update the JS enabled state.</span>
</span></span><mark><span>  <span>document</span>.body.dataset.jsEnabled = <span>'true'</span>;
</span></mark><span><span>}
</span></span><span><span>
</span></span></code></span><small id="shcb-language-3"><span>Code language:</span> <span>JavaScript</span> <span>(</span><span>javascript</span><span>)</span></small>
```

The nice thing about using a data attribute is the JavaScript code only needs to update one value.

In the CSS, we’ll want to update the existing `:invalid/:valid` input styles from [Part 1](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-1-html-and-css/#how-to-avoid-invalid-styles-showing-on-page-load) to only apply when JavaScript is not available:

```
<span><code id="code-lang-css"><span><span><span>@supports</span> <span>not</span> selector(:user-invalid) {
</span></span><mark><span>  <span>[data-js-enabled=<span>'false'</span>]</span> <span>input</span><span>:invalid</span> {
</span></mark><span><span>    <span>/* invalid input UI styles */</span>
</span></span><span><span>  }
</span></span><mark><span>  <span>[data-js-enabled=<span>'false'</span>]</span> <span>input</span><span>:valid</span> {
</span></mark><span><span>    <span>/* valid input UI styles */</span>
</span></span><span><span>  }
</span></span><span><span>}
</span></span></code></span><small id="shcb-language-4"><span>Code language:</span> <span>CSS</span> <span>(</span><span>css</span><span>)</span></small>
```

_And that’s it!_ No more invalid styles on page load for all browsers.

Below you can see the before (left) and after (right) difference in a browser (Chrome version 116) that does not support the `:user-invalid`/`:user-valid` pseudo-classes:

![A before & after showing the form prematurely invalid in the before image. The after image shows no premature invalid validation.](https://cloudfour.com/wp-content/uploads/2023/08/Screen-Shot-2023-08-04-at-9.04.34-AM-1024x886.png)

Before (left): Without JavaScript, Chrome version 116 shows invalid styles on page load.  
After (right): With JavaScript, Chrome version 116 no longer shows invalid styles on page load.

**Note:** Chrome [intends to ship support soon](https://chromestatus.com/feature/5132477781245952) for the `:user-invalid`/`:user-valid` pseudo-classes. _Woohoo!_ 🎉

The CSS change we just made _does_ mean browsers that only support `:invalid`/`:valid` no longer have _any_ input validation styles. But no need to fret! We’ll reintroduce those styles back in a moment.

[Permalink to Turning off the built-in form submit validation](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-2-layering-in-javascript/#turning-off-the-built-in-form-submit-validation)

## Turning off the built-in form submit validation

By default, submitting a form validates the form data. If invalid, the browser prevents the form submission and displays the built-in error message bubble next to the first invalid form control.

![A form in Chrome showing the built-in error message bubble for the first name field, reading "Please fill out this field".](https://cloudfour.com/wp-content/uploads/2023/08/Screen-Shot-2023-08-04-at-5.42.14-AM-847x1024.png)

The built-in browser-specific error message bubble renders when a form is submitted by default.  
Shown above is Chrome’s error message bubble.

When the browser prevents a form submission, the [form’s `submit` event does not fire](https://developer.mozilla.org/en-US/docs/Web/API/HTMLFormElement/submit_event#sect1). We’ll need to hook into the `submit` event to validate the form with JavaScript, so we’ll want to turn off the form submission prevention feature. Turning this feature off will also remove the error message bubbles, which isn’t bad because, as noted in the first article, [native error message bubbles are not accessible](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-1-html-and-css/#cons) (we’ll add more _accessible_ error messages back a bit later).

We can turn off the built-in feature by adding a [`novalidate` attribute](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/form#novalidate) to the `form` element.

The attribute should be added via JavaScript to ensure non-JavaScript experiences are unaffected. Let’s add a couple more lines to our `init` function responsible for:

-   Adding a `novalidate` attribute to the `form` element
-   Adding a form `submit` event listener

```
<span><code id="code-lang-javascript"><span><span><span>/**</span>
</span></span><span><span><span> * Initialize validation setup</span>
</span></span><span><span><span> */</span>
</span></span><span><span><span>const</span> init = <span><span>()</span> =&gt;</span> {
</span></span><span><span>  <span>const</span> formEl = <span>document</span>.querySelector(<span>'#demo-form'</span>);
</span></span><span><span>  <span>// Turn off built-in form submit validation. </span>
</span></span><mark><span>  formEl.setAttribute(<span>'novalidate'</span>, <span>''</span>);
</span></mark><span><span>  <span>// Handle form submit validation via JS instead.</span>
</span></span><mark><span>  formEl.addEventListener(<span>'submit'</span>, onSubmit);
</span></mark><span><span>
</span></span><span><span>  <span>// Other setup code…</span>
</span></span><span><span>}
</span></span></code></span><small id="shcb-language-5"><span>Code language:</span> <span>JavaScript</span> <span>(</span><span>javascript</span><span>)</span></small>
```

[Permalink to Why are we setting the `novalidate` attribute value to an empty string?](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-2-layering-in-javascript/#why-are-we-setting-the-novalidate-attribute-value-to-an-empty-string)

### Why are we setting the `novalidate` attribute value to an empty string?

The `novalidate` attribute is a [boolean attribute](https://developer.mozilla.org/en-US/docs/Glossary/Boolean/HTML). Boolean attributes are `true` when they are present and false when they are absent. Technically, the value can be anything, but the convention is to use either an empty string or the attribute name as the value (e.g., `novalidate="novalidate"`).

Super! The form is now set up so JavaScript can handle the submit validation step. We’ll return to the `onSubmit` handler shortly. Keep following along!

[Permalink to Adding event listeners for live validation](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-2-layering-in-javascript/#adding-event-listeners-for-live-validation)

## Adding event listeners for live validation

By default, form validation only happens when a form is submitted. But with JavaScript, validation can occur as a user types (real-time validation using `input` or `change` events) or moves away from an input field (late validation using the `blur` event); these are known as “live validation” patterns. Your project’s UX design will determine whether or not you need any live validation. For the sake of this demo, though, let’s implement both real-time and late validation to understand how to set it up.

We’ll first add a CSS class so our JavaScript can hook into all form controls we want to validate using the Constraint Validation API. Let’s use a `js-validate` class:

```
<span><code id="code-lang-xml"><span><span><span>&lt;<span>label</span> <span>for</span>=<span>"customer-first-name"</span>&gt;</span>First name:<span>&lt;/<span>label</span>&gt;</span>
</span></span><span><span><span>&lt;<span>input</span></span>
</span></span><span><span><span>  <span>id</span>=<span>"customer-first-name"</span></span>
</span></span><span><span><span>  <span>name</span>=<span>"customerFirstName"</span></span>
</span></span><mark><span><span>  <span>class</span>=<span>"js-validate"</span></span>
</span></mark><span><span><span>  <span>type</span>=<span>"text"</span></span>
</span></span><span><span><span>  <span>required</span></span>
</span></span><span><span><span>/&gt;</span>
</span></span></code></span><small id="shcb-language-6"><span>Code language:</span> <span>HTML, XML</span> <span>(</span><span>xml</span><span>)</span></small>
```

Back in the `init` function, let’s add JavaScript event listeners for `input` and `blur` events for each of the `js-validate` input elements:

```
<span><code id="code-lang-javascript"><span><span><span>/**</span>
</span></span><span><span><span> * Initialize validation setup</span>
</span></span><span><span><span> */</span>
</span></span><span><span><span>const</span> init = <span><span>()</span> =&gt;</span> {
</span></span><span><span>  <span>// Set up `blur` and `input` validation for the inputs that can be </span>
</span></span><span><span>  <span>// validated with the Constraint Validation API.</span>
</span></span><mark><span>  <span>document</span>.querySelectorAll(<span>'.js-validate'</span>).forEach(<span>(<span>inputEl</span>) =&gt;</span> {
</span></mark><mark><span>    inputEl.addEventListener(<span>'input'</span>, (event) =&gt;
</span></mark><span><span>      <span>// Call input validation handler function</span>
</span></span><span><span>    );
</span></span><mark><span>    inputEl.addEventListener(<span>'blur'</span>, (event) =&gt;
</span></mark><span><span>      <span>// Call input validation handler function</span>
</span></span><span><span>    );
</span></span><span><span>  });
</span></span><span><span>
</span></span><span><span>  <span>// Other setup code…</span>
</span></span><span><span>}
</span></span></code></span><small id="shcb-language-7"><span>Code language:</span> <span>JavaScript</span> <span>(</span><span>javascript</span><span>)</span></small>
```

Sweet! Next, we can add a JavaScript function that uses the Constraint Validation API to validate the input data.

[Permalink to Using the Constraint Validation API to validate and update the UI state](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-2-layering-in-javascript/#using-the-constraint-validation-api-to-validate-and-update-the-ui-state)

## Using the Constraint Validation API to validate and update the UI state

We’ll want to create a function to call when the `input` or `blur` events fire. Let’s name the function `updateValidationStateForInput`, and it will be responsible for:

-   Using the [`HTMLInputElement.checkValidity` method](https://developer.mozilla.org/en-US/docs/Web/API/HTMLInputElement/checkValidity) from the [Constraint Validation API](https://developer.mozilla.org/en-US/docs/Learn/Forms/Form_validation#the_constraint_validation_api) to check if the data is valid for a given input based on it’s `type` (e.g., `type="email"`) and validation attributes (e.g., `required`)
-   Using the `checkValidity` value to update the input’s valid/invalid CSS classes and also the [`aria-invalid` attribute](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-invalid) value

[Permalink to What does `aria-invalid` do?](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-2-layering-in-javascript/#what-does-aria-invalid-do)

### What does `aria-invalid` do?

The `aria-invalid` attribute enables assistive technologies to convey additional validation feedback to users:

> When a field has `aria-invalid` set to “true”, VoiceOver in Safari announces “invalid data” when the field gets focus; JAWS and NVDA notify the error as an “invalid entry”.
> 
> [Using Aria-Invalid to Indicate An Error Field](https://www.w3.org/WAI/WCAG21/Techniques/aria/ARIA21)

```
<span><code id="code-lang-javascript"><span><span><span>/**</span>
</span></span><span><span><span> * Update the validation UI state for a given input element.</span>
</span></span><span><span><span> * <span>@param <span>{HTMLInputElement}</span> </span>inputEl The input element to update the UI state for.</span>
</span></span><span><span><span><span> */</span></span>
</span></span><span><span><span><span>const</span> updateValidationStateForInput = <span>(<span>inputEl</span>) =&gt;</span> {</span>
</span></span><span><span><span><span>  </span></span>
</span></span><span><span><span><span>  </span></span>
</span></span><span><span><span><span>  </span></span>
</span></span><mark><span><span><span>  <span>const</span> isInputValid = inputEl.checkValidity();</span></span>
</span></mark><span><span><span><span>  </span></span>
</span></span><mark><span><span><span>  inputEl.classList.toggle(<span>'is-valid'</span>, isInputValid);</span></span>
</span></mark><mark><span><span><span>  inputEl.classList.toggle(<span>'is-invalid'</span>, !isInputValid);</span></span>
</span></mark><span><span><span><span>  </span></span>
</span></span><span><span><span><span>  </span></span>
</span></span><mark><span><span><span>  inputEl.setAttribute(<span>'aria-invalid'</span>, (!isInputValid).toString());</span></span>
</span></mark><span><span><span><span>};</span></span>
</span></span></code></span><small id="shcb-language-8"><span>Code language:</span> <span>JavaScript</span> <span>(</span><span>javascript</span><span>)</span></small>
```

[Permalink to Did you notice?](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-2-layering-in-javascript/#did-you-notice)

### Did you notice?

Thanks to the browser’s [native HTML form validation features](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-1-html-and-css/#browser-built-in-form-validation-as-the-foundation), input validation happened magically with a single call to the Constraint Validation API’s `checkValidity` method—no need for custom validation logic. Let the browser do the work!

Also of note, a similar method, `[reportValidity](https://developer.mozilla.org/en-US/docs/Web/API/HTMLInputElement/reportValidity)`, performs the same validity check as `checkValidity`. We don’t use `reportValidity` because it also reports the outcome to the user, meaning the browser will display the [built-in non-accessible error message bubble](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-1-html-and-css/#error-message-bubble) and double up any custom-designed validation error messages.

With the `is-valid`/`is-invalid` class toggle logic set up, we can add new CSS rules to style each of the UI states for the inputs:

```
<span><code id="code-lang-css"><span>/**
 * Provide an enhanced and consistent experience when JS is enabled. 
 */</span>
<span>input</span><span>.is-invalid</span> {
  <span>/* Invalid input UI styles */</span>
}
<span>input</span><span>.is-valid</span> {
  <span>/* Valid input UI styles */</span>
}</code></span><small id="shcb-language-9"><span>Code language:</span> <span>CSS</span> <span>(</span><span>css</span><span>)</span></small>
```

This also means we can contain the `:user-invalid`/`:user-valid` CSS rules to only apply when JavaScript is not available. We’ll want to update the existing selectors from [Part 1](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-1-html-and-css/#how-to-avoid-invalid-styles-showing-on-page-load) as follows:

-   Add `[data-js-enabled='false']` to the `:user-invalid`/`:user-valid` selectors

```
<span><code id="code-lang-css"><span><span><span>/**</span>
</span></span><span><span><span> * For browsers that support :user-invalid/:user-valid</span>
</span></span><span><span><span> */</span>
</span></span><mark><span><span>[data-js-enabled=<span>'false'</span>]</span> <span>input</span><span>:user-invalid</span> {
</span></mark><span><span>  <span>/* Invalid input UI styles */</span>
</span></span><span><span>}
</span></span><mark><span><span>[data-js-enabled=<span>'false'</span>]</span> <span>input</span><span>:user-valid</span> {
</span></mark><span><span>  <span>/* Valid input UI styles */</span>
</span></span><span><span>}
</span></span></code></span><small id="shcb-language-10"><span>Code language:</span> <span>CSS</span> <span>(</span><span>css</span><span>)</span></small>
```

With these updates, the `:invalid`/`:valid` and `:user-invalid`/`:user-valid` CSS rules now only apply when JavaScript is unavailable (the base experience). JavaScript is fully responsible for all valid/invalid states via the new `is-invalid`/`is-valid` CSS rules. This helps create a consistent user experience across all browsers when JavaScript is enabled and addresses any browser implementation bugs that may exist (e.g., [`:user-invalid` doesn’t trigger on form submit in Safari](https://bugs.webkit.org/show_bug.cgi?id=257988)).

Moving along, we can then call the newly created `updateValidationStateForInput` function on `input` and `blur`. We also want to set the initial value of the `aria-invalid` attribute:

```
<span><code id="code-lang-javascript"><span><span><span>/**</span>
</span></span><span><span><span> * Initialize validation setup</span>
</span></span><span><span><span> */</span>
</span></span><span><span><span>const</span> init = <span><span>()</span> =&gt;</span> {
</span></span><span><span>  <span>document</span>.querySelectorAll(<span>'.js-validate'</span>).forEach(<span>(<span>inputEl</span>) =&gt;</span> {
</span></span><span><span>    <span>// Set up `blur` and `input` validation for the inputs that can be </span>
</span></span><span><span>    <span>// validated with the Constraint Validation API.</span>
</span></span><span><span>    inputEl.addEventListener(<span>'input'</span>, (event) =&gt;
</span></span><mark><span>      updateValidationStateForInput(event.target)
</span></mark><span><span>    );
</span></span><span><span>    inputEl.addEventListener(<span>'blur'</span>, (event) =&gt;
</span></span><mark><span>      updateValidationStateForInput(event.target)
</span></mark><span><span>    );
</span></span><span><span>    <span>// Should be set to "false" before any validation occurs.</span>
</span></span><mark><span>    inputEl.setAttribute(<span>'aria-invalid'</span>, <span>'false'</span>);
</span></mark><span><span>  });
</span></span><span><span>
</span></span><span><span>  <span>// Other setup code…</span>
</span></span><span><span>}
</span></span></code></span><small id="shcb-language-11"><span>Code language:</span> <span>JavaScript</span> <span>(</span><span>javascript</span><span>)</span></small>
```

_Exciting!_ The form controls now have live validation. Below you can see each input’s UI styles showing both the invalid and valid styles live (as we interact with the form control):

Each input’s invalid/valid UI state is displayed live as the user interacts with the form control.

[Permalink to Managing the validation states for optional fields](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-2-layering-in-javascript/#managing-the-validation-states-for-optional-fields)

## Managing the validation states for optional fields

The previous section’s valid/invalid class toggle logic only accounts for situations where all fields are required (e.g., have a `required` attribute). We’ll need to tweak the logic if the form includes optional fields. Otherwise, an empty optional field could appear as “valid.” Or a validation error message might display without the input’s “invalid” state.

To fix these issues, we’ll add the following logic to the `updateValidationStateForInput` function:

-   If an optional field is empty, remove all validation styles

```
<span><code id="code-lang-javascript"><span><span><span>const</span> updateValidationStateForInput = <span>(<span>inputEl</span>) =&gt;</span> {
</span></span><span><span>  <span>// Existing code from above here…</span>
</span></span><span><span>
</span></span><span><span>  <span>// Handle optional fields that are empty</span>
</span></span><mark><span>  <span>if</span> (!inputEl.required &amp;&amp; inputEl.value === <span>''</span> &amp;&amp; isInputValid) {
</span></mark><span><span>    <span>// Clear validation states.</span>
</span></span><mark><span>    inputEl.classList.remove(<span>'is-valid'</span>, <span>'is-invalid'</span>);
</span></mark><mark><span>  } <span>else</span> {
</span></mark><span><span>    <span>// Required fields: Toggle valid/invalid state classes</span>
</span></span><span><span>    inputEl.classList.toggle(<span>'is-valid'</span>, isInputValid);
</span></span><span><span>    inputEl.classList.toggle(<span>'is-invalid'</span>, !isInputValid);
</span></span><mark><span>  }
</span></mark><span><span>
</span></span><span><span>  <span>// Existing code from above here…</span>
</span></span><span><span>};
</span></span></code></span><small id="shcb-language-12"><span>Code language:</span> <span>JavaScript</span> <span>(</span><span>javascript</span><span>)</span></small>
```

[Permalink to Why check if an optional field is both empty _and_ valid?](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-2-layering-in-javascript/#why-check-if-an-optional-field-is-both-empty-and-valid)

### Why check if an optional field is both empty _and_ valid?

You may have noticed that the conditional to clear the validation states confirms that a field is optional, empty, _and_ valid. Unexpectedly, `number`\-type inputs will report empty when you enter non-numeric values in Firefox ([long Mozilla discussion](https://bugzilla.mozilla.org/show_bug.cgi?id=1398528)) and Safari. This causes a mixed, incorrect visual validation state where only the error renders, but the input won’t show the invalid state. Adding the `isInputValid` check ensures the expected behavior.

With those changes in place, empty optional fields no longer show a “valid” state, and non-numeric values in `number`\-type fields show the correct “invalid” state.

[Permalink to Handling the form `submit` event](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-2-layering-in-javascript/#handling-the-form-submit-event)

## Handling the form `submit` event

Above, we [turned off the built-in form submit validation feature](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-2-layering-in-javascript/#turning-off-the-built-in-form-submit-validation) so that we could use JavaScript to handle it instead. As a reminder, we added a `submit` event listener that calls an `onSubmit` callback function:

```
<span><code id="code-lang-javascript"><span><span><span>/**</span>
</span></span><span><span><span> * Initialize validation setup</span>
</span></span><span><span><span> */</span>
</span></span><span><span><span>const</span> init = <span><span>()</span> =&gt;</span> {
</span></span><span><span>  <span>// Other setup code…</span>
</span></span><span><span>
</span></span><span><span>  <span>// Handle form submit validation via JS instead.</span>
</span></span><mark><span>  formEl.addEventListener(<span>'submit'</span>, onSubmit);
</span></mark><span><span>}
</span></span></code></span><small id="shcb-language-13"><span>Code language:</span> <span>JavaScript</span> <span>(</span><span>javascript</span><span>)</span></small>
```

Validation UX requirements differ from project to project, but for this demo, let’s set a goal of matching the browser’s default form submission UX, which includes the following:

-   Update each of the form input’s UI state
-   Prevent form submission if the form is invalid
-   Focus on the first invalid input

Let’s write that logic out in a new `onSubmit` function:

```
<span><code id="code-lang-javascript"><span><span><span>/**</span>
</span></span><span><span><span> * Handler for form submit event.</span>
</span></span><span><span><span> * <span>@param <span>{SubmitEvent}</span> <span>event</span></span></span>
</span></span><span><span><span><span> */</span></span>
</span></span><span><span><span><span>const</span> onSubmit = <span>(<span>event</span>) =&gt;</span> {</span>
</span></span><span><span><span><span>  </span></span>
</span></span><mark><span><span><span>  <span>document</span></span></span>
</span></mark><mark><span><span><span>    .querySelectorAll(<span>'.js-validate'</span>)</span></span>
</span></mark><mark><span><span><span>    .forEach(updateValidationStateForInput);</span></span>
</span></mark><span><span><span><span>  </span></span>
</span></span><mark><span><span><span>  <span>const</span> formEl = event.target;</span></span>
</span></mark><span><span><span><span>  </span></span>
</span></span><span><span><span><span>  </span></span>
</span></span><mark><span><span><span>  <span>const</span> isFormValid = formEl.checkValidity();</span></span>
</span></mark><span><span><span><span>  </span></span>
</span></span><mark><span><span><span>  <span>if</span> (!isFormValid) {</span></span>
</span></mark><mark><span><span><span>    event.preventDefault();</span></span>
</span></mark><mark><span><span><span>  }</span></span>
</span></mark><span><span><span><span>  </span></span>
</span></span><mark><span><span><span>  <span>const</span> firstInvalidInputEl = formEl.querySelector(<span>'input:invalid'</span>);</span></span>
</span></mark><mark><span><span><span>  firstInvalidInputEl?.focus();</span></span>
</span></mark><span><span><span><span>};</span></span>
</span></span></code></span><small id="shcb-language-14"><span>Code language:</span> <span>JavaScript</span> <span>(</span><span>javascript</span><span>)</span></small>
```

[Permalink to Hold up, `checkValidity` on the `form` element?](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-2-layering-in-javascript/#hold-up-checkvalidity-on-the-form-element)

### Hold up, `checkValidity` on the `form` element?

Great observation! The `checkValidity` method of the [Constraint Validation API](https://developer.mozilla.org/en-US/docs/Learn/Forms/Form_validation#the_constraint_validation_api) is available not only for `input` elements but for the `form` element also. This provides the flexibility to validate individual inputs as needed (e.g., live validation) and the form as a whole (e.g., form submission). And it’s all powered by each input’s [constraint validation attributes](https://developer.mozilla.org/en-US/docs/Learn/Forms/Form_validation#using_built-in_form_validation), wonderful!

_Hooray!_ Form submit validation is now wired up and working. You can see it in action below:

All `js-validate` inputs are validated on form submission; if invalid, form submission is prevented, and the first input with an error is focused.

[Permalink to Using a custom design for validation error messages](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-2-layering-in-javascript/#using-a-custom-design-for-validation-error-messages)

## Using a custom design for validation error messages

You may have noticed we no longer have validation error messages to provide feedback to the user. The lack of validation messages results from [adding the `novalidate` attribute to the `form` element](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-2-layering-in-javascript/#turning-off-the-built-in-form-submit-validation) and is a regression from the browser’s default validation UX. Let’s fix this by bringing them back using a custom design.

We’ll add an “error” element (a paragraph tag is fine) below each `js-validate` input, where the validation message will be displayed. We want to make sure of a few details:

-   The “error” element should have a [`hidden` attribute](https://developer.mozilla.org/en-US/docs/Web/HTML/Global_attributes/hidden) so it is not displayed by default
-   The input should have an [`aria-describedby` attribute](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-describedby) with the ID of the “error” element so [assistive technologies can convey validation feedback](https://www.smashingmagazine.com/2023/02/guide-accessible-form-validation/#field-description) to users when the input is in focus. This addresses [WCAG 2.1 Success Criterion 1.3.1: Info and Relationships (Level A)](https://www.w3.org/WAI/WCAG21/Understanding/info-and-relationships.html).

There’s also an [`aria-errormessage` attribute](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-errormessage) that is more aligned to this use case but [does not have great support](https://a11ysupport.io/tech/aria/aria-errormessage_attribute) yet. For now, `aria-describedby` is the better choice, though it’s important to note that Chromium browsers treat `aria-describedby` as an assertive live region. For a deeper dive comparing `aria-describedby` and `aria-errormessage`, read [“Exposing Field Errors” by Adrian Roselli](https://adrianroselli.com/2023/04/exposing-field-errors.html).

```
<span><code id="code-lang-xml"><span><span><span>&lt;<span>label</span> <span>for</span>=<span>"customer-first-name"</span>&gt;</span>First name:<span>&lt;/<span>label</span>&gt;</span>
</span></span><span><span><span>&lt;<span>input</span></span>
</span></span><span><span><span>  <span>id</span>=<span>"customer-first-name"</span></span>
</span></span><span><span><span>  <span>name</span>=<span>"customerFirstName"</span></span>
</span></span><span><span><span>  <span>class</span>=<span>"js-validate"</span></span>
</span></span><span><span><span>  <span>type</span>=<span>"text"</span></span>
</span></span><span><span><span>  <span>required</span></span>
</span></span><mark><span><span>  <span>aria-describedby</span>=<span>"customer-first-name-error"</span></span>
</span></mark><span><span><span>/&gt;</span>
</span></span><mark><span><span>&lt;<span>p</span> <span>hidden</span> <span>id</span>=<span>"customer-first-name-error"</span> <span>class</span>=<span>"error"</span>&gt;</span>
</span></mark><mark><span>  <span>&lt;!-- Text content will be set via JS --&gt;</span>
</span></mark><mark><span><span>&lt;/<span>p</span>&gt;</span>
</span></mark></code></span><small id="shcb-language-15"><span>Code language:</span> <span>HTML, XML</span> <span>(</span><span>xml</span><span>)</span></small>
```

The error messages are placed under the fields for this demo, though this pattern has some issues. Learn more about this from an excellent [article explaining why putting messages under fields may not be the best option by Adrian Roselli](https://adrianroselli.com/2017/01/avoid-messages-under-fields.html).

We’ll need to add logic to the `updateValidationStateForInput` function to:

-   Set the error message using the input’s `validationMessage` property
-   Update the error message element’s `hidden` property accordingly

[Permalink to What is the `validationMessage` property?](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-2-layering-in-javascript/#what-is-the-validationmessage-property)

### What is the `validationMessage` property?

The Constraint Validation API makes the [`validationMessage` property](https://web.dev/constraintvalidation/#validationmessage) available on `input` elements and allows us to get the localized browser-specific error message describing the validation constraints that have not been satisfied for the given input. An empty string is returned if the input data satisfies its constraints.

```
<span><code id="code-lang-javascript"><span><span><span>/**</span>
</span></span><span><span><span> * Update the validation UI state for a given input element.</span>
</span></span><span><span><span> * <span>@param <span>{HTMLInputElement}</span> </span>inputEl The input element to update the UI state for.</span>
</span></span><span><span><span><span> */</span></span>
</span></span><span><span><span><span>const</span> updateValidationStateForInput = <span>(<span>inputEl</span>) =&gt;</span> {</span>
</span></span><span><span><span><span>  </span></span>
</span></span><span><span><span><span>  </span></span>
</span></span><span><span><span><span>  </span></span>
</span></span><span><span><span><span>  <span>const</span> isInputValid = inputEl.checkValidity();</span></span>
</span></span><span><span><span><span></span></span>
</span></span><span><span><span><span>  </span></span>
</span></span><span><span><span><span></span></span>
</span></span><span><span><span><span>  </span></span>
</span></span><mark><span><span><span>  <span>const</span> errorEl = inputEl.nextElementSibling;</span></span>
</span></mark><span><span><span><span>  </span></span>
</span></span><span><span><span><span>  </span></span>
</span></span><span><span><span><span>  </span></span>
</span></span><mark><span><span><span>  errorEl.textContent = inputEl.validationMessage;</span></span>
</span></mark><span><span><span><span>  </span></span>
</span></span><mark><span><span><span>  errorEl.hidden = isInputValid;</span></span>
</span></mark><span><span><span><span>};</span></span>
</span></span></code></span><small id="shcb-language-16"><span>Code language:</span> <span>JavaScript</span> <span>(</span><span>javascript</span><span>)</span></small>
```

And, _tada!_ The form now uses a custom design for the validation error messages. The best part is we get all the built-in error messages for _free_! Below, notice the email input has a series of browser-specific validation messages depending on which validation constraint fails. Pretty neat for only a few lines of code!

With live validation set up, the user gets feedback when the input and blur events trigger.

The validation error message design in the demo is straightforward (red text below the input), but with the full power of CSS at our disposal, we can get as creative as we’d like. We are no longer locked into the browser’s built-in non-accessible error bubbles that may also not fit the rest of our site’s design.

[Permalink to Managing the validation state for sticky field values](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-2-layering-in-javascript/#managing-the-validation-state-for-sticky-field-values)

## Managing the validation state for sticky field values

If you happen to be a Firefox browser user, you may have noticed that input field values hang around after a page refresh. When this happens, the valid/invalid UI states are missing:

![A fieldset with first name, last name, and email fields (all required). The first name field is prefilled with "Gerardo". Last name field is prefilled with "Rodriguez". Email is prefilled with "gerardo". None of the fields show their proper validation state.](https://cloudfour.com/wp-content/uploads/2023/08/Screen-Shot-2023-08-31-at-4.52.00-AM-1024x1024.png)

In Firefox, input field values persist after a page refresh, but the valid/invalid UI states are missing.

To ensure we account for this use case, we can add a bit of code to the existing `init` function:

-   Run the `updateValidationStateForInput` function for each `js-validate` input
-   Only call the function if the field is not empty (otherwise, empty fields will show the “invalid” state prematurely)

```
<span><code id="code-lang-javascript"><span><span><span>const</span> init = <span><span>()</span> =&gt;</span> {
</span></span><span><span>  <span>// Existing setup code…</span>
</span></span><span><span>
</span></span><span><span>  <span>document</span>
</span></span><span><span>    .querySelectorAll(<span>'.js-validate'</span>)
</span></span><span><span>    .forEach(<span>(<span>inputEl</span>) =&gt;</span> {
</span></span><span><span>      <span>// Existing code from above here…</span>
</span></span><span><span>      
</span></span><span><span>      <span>// Update the state for prefilled inputs.</span>
</span></span><mark><span>      <span>if</span> (inputEl.value !== <span>''</span>) {
</span></mark><mark><span>        updateValidationStateForInput(inputEl);
</span></mark><mark><span>      }
</span></mark><span><span>    });
</span></span><span><span>}
</span></span></code></span><small id="shcb-language-17"><span>Code language:</span> <span>JavaScript</span> <span>(</span><span>javascript</span><span>)</span></small>
```

The prefilled input fields now show their appropriate valid/invalid UI states. Much better!

![A fieldset with first name, last name, and email fields (all required). The first name field is prefilled with "Gerardo". Last name field is prefilled with "Rodriguez". Email is prefilled with "gerardo". First and last name fields show the "valid" UI state. The email field shows the "invalid" UI state.](https://cloudfour.com/wp-content/uploads/2023/08/Screen-Shot-2023-08-31-at-4.54.14-AM-980x1024.png)

If input field values persist after a page refresh, the valid/invalid UI states are now displayed.

[Permalink to What about inputs that cannot be validated with the Constraint Validation API?](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-2-layering-in-javascript/#what-about-inputs-that-cannot-be-validated-with-the-constraint-validation-api)

## What about inputs that cannot be validated with the Constraint Validation API?

If you find yourself in this uncommon situation, you can use custom JavaScript to validate the input data.

A `checkbox` group is an example that native browser validation features will not validate. [Part 3](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-3-validating-a-checkbox-group/) of this article series examines one way to solve this challenge.

An “interests” checkbox group showing live validation in action.

[Permalink to A note on form validation and security](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-2-layering-in-javascript/#a-note-on-form-validation-and-security)

## A note on form validation and security

Client-side validation is an important feature to help provide an enhanced, more accessible user experience allowing users to fix invalid data immediately before submitting it to the server. However, the data validation process should also include server-side validation because a malicious user can easily bypass client-side validation, allowing them to send bad data to the server. You can read more about [website security](https://developer.mozilla.org/en-US/docs/Learn/Server-side/First_steps/Website_security) on MDN.

[Permalink to Wrapping up](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-2-layering-in-javascript/#wrapping-up)

## Wrapping up

Thank you for following along! It was fun progressively enhancing the form validation experience with JavaScript and making it more accessible, all while using [built-in validation features as the foundation](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-1-html-and-css/#browser-built-in-form-validation-as-the-foundation).

As mentioned above, [Part 3](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-3-validating-a-checkbox-group/) of this series dives into writing custom JavaScript validation for a `checkbox` group.

[Part 4](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-4-custom-validation-messages/) explores using the Constraint Validation API’s [`ValidityState` interface](https://developer.mozilla.org/en-US/docs/Web/API/ValidityState) to help render custom validation error messages.

Stay tuned!

A special thanks to [Tyler Sticka](https://cloudfour.com/is/tyler/) for challenging me to think about form validation from a different perspective. At some point in my journey, the story I created around form validation immediately jumped to using validation libraries or custom JavaScript without considering the browser’s built-in Constraint Validation API. In retrospect, it seems silly not to use the Constraint Validation API; no need to reinvent the wheel! Thanks for always inspiring me to strive for continuous growth. (And thank you for the SVG validation icons!)

Also, a huge thank you to [Juliette Alexandria](https://www.linkedin.com/in/juliette-alexandria-8946a91b0/) and [Adrian Roselli](https://adrianroselli.com/) for reviewing this article and providing accessibility feedback. 🙌🏽

[Permalink to More resources](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-2-layering-in-javascript/#more-resources)

## More resources

-   [A Guide To Accessible Form Validation](https://www.smashingmagazine.com/2023/02/guide-accessible-form-validation/) by Sandrina Pereira
-   [Avoid Default Field Validation](https://adrianroselli.com/2019/02/avoid-default-field-validation.html) by Adrian Roselli
-   [Designing Better Error Messages UX](https://www.smashingmagazine.com/2022/08/error-messages-ux-design/) and [A Complete Guide To Live Validation UX](https://www.smashingmagazine.com/2022/09/inline-validation-web-forms-ux/) by Vitaly Friedman
-   [Accessible Rich Internet Applications (WAI-ARIA) 1.3: `aria-invalid`](https://w3c.github.io/aria/#aria-invalid)
-   [MDN Web Docs: Built-in form validation examples](https://developer.mozilla.org/en-US/docs/Learn/Forms/Form_validation#built-in_form_validation_examples)
-   [MDN Web Docs: Validating forms using JavaScript](https://developer.mozilla.org/en-US/docs/Learn/Forms/Form_validation#validating_forms_using_javascript)
-   [MDN Web Docs: Complex constraints using the Constraint Validation API](https://developer.mozilla.org/en-US/docs/Web/HTML/Constraint_validation#complex_constraints_using_the_constraint_validation_api)

[Permalink to Missed an article in the series?](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-2-layering-in-javascript/#missed-an-article-in-the-series)

## Missed an article in the series?

I’ve got you! Listed below are all of the articles from the series:

-   [Part 1: HTML and CSS](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-1-html-and-css/)
-   [Part 2: Layering in JavaScript](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-2-layering-in-javascript/)
-   [Part 3: Validating a checkbox group](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-3-validating-a-checkbox-group/)
-   [Part 4: Custom validation messages](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-4-custom-validation-messages/)
