---
created: 2024-09-24T13:20:14 (UTC -04:00)
tags: []
source: https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-4-custom-validation-messages/
author: Gerardo Rodriguez
---

# Progressively Enhanced Form Validation, Part 4: Custom validation messages – Cloud Four

> ## Excerpt
> Part 4 explores the ValidityState API, a powerful, approachable, and well-supported API we can use to define custom validation messages.

---
![Three icons. Icon 1: representing an invalid state, a fuscia circle shape with a white exclamation mark in the center. Icon 2: representing a valid state, a green circle shape with a white checkmark in the center. Icon 3: A talking bubble with purple squiggles representing custom validation messages.](https://cloudfour.com/wp-content/uploads/2023/08/part4-1-1024x576.png)

[Part 1](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-1-html-and-css/) of this series explored the browser’s built-in HTML and CSS form validation features. [Part 2](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-2-layering-in-javascript/) enhanced the experience by layering in JavaScript using the Constraint Validation API. [Part 3](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-3-validating-a-checkbox-group/) dug into custom validation handling for a `checkbox` group leveraging the FormData API.

This article explores the [ValidityState API](https://developer.mozilla.org/en-US/docs/Web/API/ValidityState), a powerful, approachable, and [well-supported](https://caniuse.com/mdn-api_validitystate) API we can use to define custom validation messages.

Feel free to view the [demo for this article](https://constraint-validation-api-demo.netlify.app/part-4/) as a reference. The [source code is available on GitHub](https://github.com/cloudfour/constraint-validation-api-demo).

Join along as we explore the following in this article:

1.  [ValidityState API overview](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-4-custom-validation-messages/#validitystate-api-overview)
2.  [Let’s add more demo fields](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-4-custom-validation-messages/#lets-add-more-demo-fields)
3.  [Adding custom validation messages](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-4-custom-validation-messages/#adding-custom-validation-messages)
4.  [Updating the demo to use custom validation messages](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-4-custom-validation-messages/#updating-the-demo-to-use-custom-validation-messages)
5.  [What about localized validation messages?](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-4-custom-validation-messages/#what-about-localized-validation-messages)

I’m excited, let’s jump in!

[Permalink to ValidityState API overview](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-4-custom-validation-messages/#validitystate-api-overview)

## ValidityState API overview

The [ValidityState API](https://developer.mozilla.org/en-US/docs/Web/API/ValidityState) gives us access to an object containing all the states for an input represented as read-only boolean properties with respect to the input’s [native validation constraints](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-1-html-and-css/#browser-built-in-form-validation-as-the-foundation).

You can find a list of all [instance properties on MDN](https://developer.mozilla.org/en-US/docs/Web/API/ValidityState#instance_properties). Below are the ones we’ll use in this demo:

-   `[badInput](https://developer.mozilla.org/en-US/docs/Web/API/ValidityState/badInput)`: Is `true` when the browser is unable to convert the value (e.g., a non-numeric value in a number input)
-   `[patternMismatch](https://developer.mozilla.org/en-US/docs/Web/API/ValidityState/patternMismatch)`: Is `true` if the value doesn’t match the [`pattern` attribute](https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/pattern) regular expression
-   `[rangeOverflow](https://developer.mozilla.org/en-US/docs/Web/API/ValidityState/rangeOverflow)`: Is `true` if the value is greater than the [`max` attribute](https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/max)
-   `[rangeUnderflow](https://developer.mozilla.org/en-US/docs/Web/API/ValidityState/rangeUnderflow)`: Is `true` if the value is less than the [`min` attribute](https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/min)
-   `[stepMismatch](https://developer.mozilla.org/en-US/docs/Web/API/ValidityState/stepMismatch)`: Is `true` if the value doesn’t conform to the [`step` attribute](https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/step)
-   `[tooLong](https://developer.mozilla.org/en-US/docs/Web/API/ValidityState/tooLong)`: Is `true` if the value length exceeds the [`maxlength` attribute](https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/maxlength)
-   `[tooShort](https://developer.mozilla.org/en-US/docs/Web/API/ValidityState/tooShort)`: Is `true` if the value length is less than the [`minlength` attribute](https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/minlength)
-   `[typeMismatch](https://developer.mozilla.org/en-US/docs/Web/API/ValidityState/typeMismatch)`: Is `true` if the value format doesn’t match the [`type` attribute](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-1-html-and-css/#input-type-attributes) (when `type` is `"email"` or `"url"`)
-   `[valueMissing](https://developer.mozilla.org/en-US/docs/Web/API/ValidityState/valueMissing)`: Is `true` when the [`required` attribute](https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/required) is present and no value is provided
-   `[valid](https://developer.mozilla.org/en-US/docs/Web/API/ValidityState#valid)`: Is `true` when all input validation constraints are satisfied, `false` otherwise

To better understand the API, let’s look at an example. If we have an email input with `type` and `required` validation constraints:

```
<span><code id="code-lang-xml"><span><span><span>&lt;<span>input</span> </span>
</span></span><span><span><span>  <span>id</span>=<span>"customer-email"</span> </span>
</span></span><span><span><span>  <span>name</span>=<span>"customerEmail"</span> </span>
</span></span><mark><span><span>  <span>type</span>=<span>"email"</span> </span>
</span></mark><mark><span><span>  <span>required</span> </span>
</span></mark><span><span><span>  <span>aria-described-by</span>=<span>"customer-email-error"</span> </span>
</span></span><span><span><span>/&gt;</span>
</span></span></code></span><small id="shcb-language-1"><span>Code language:</span> <span>HTML, XML</span> <span>(</span><span>xml</span><span>)</span></small>
```

We can use JavaScript to access the input’s `validity` property to get the ValidityState object:

```
<span><code id="code-lang-javascript"><span><span><span>const</span> inputEl = <span>document</span>.getElementById(<span>'customer-email'</span>);
</span></span><mark><span><span>console</span>.log(inputEl.validity);
</span></mark></code></span><small id="shcb-language-2"><span>Code language:</span> <span>JavaScript</span> <span>(</span><span>javascript</span><span>)</span></small>
```

Which logs the following:

```
<span><code id="code-lang-json"><span><span>{
</span></span><span><span>  badInput: <span>false</span>;
</span></span><span><span>  customError: <span>false</span>;
</span></span><span><span>  patternMismatch: <span>false</span>;
</span></span><span><span>  rangeOverflow: <span>false</span>;
</span></span><span><span>  rangeUnderflow: <span>false</span>;
</span></span><span><span>  stepMismatch: <span>false</span>;
</span></span><span><span>  tooLong: <span>false</span>;
</span></span><span><span>  tooShort: <span>false</span>;
</span></span><span><span>  typeMismatch: <span>false</span>;
</span></span><mark><span>  valid: <span>false</span>;
</span></mark><mark><span>  valueMissing: <span>true</span>;
</span></mark><span><span>}
</span></span></code></span><small id="shcb-language-3"><span>Code language:</span> <span>JSON / JSON with Comments</span> <span>(</span><span>json</span><span>)</span></small>
```

You’ll notice the `valid` property is `false` and the `valueMissing` property is `true`. This means the field value is empty and fails the `required` validation constraint. If we were to satisfy the `required` constraint by entering an invalid email value, say “asdf,” the ValidityState object would update as follows:

```
<span><code id="code-lang-json"><span><span>{
</span></span><span><span>  badInput: <span>false</span>;
</span></span><span><span>  customError: <span>false</span>;
</span></span><span><span>  patternMismatch: <span>false</span>;
</span></span><span><span>  rangeOverflow: <span>false</span>;
</span></span><span><span>  rangeUnderflow: <span>false</span>;
</span></span><span><span>  stepMismatch: <span>false</span>;
</span></span><span><span>  tooLong: <span>false</span>;
</span></span><span><span>  tooShort: <span>false</span>;
</span></span><mark><span>  typeMismatch: <span>true</span>;
</span></mark><span><span>  valid: <span>false</span>;
</span></span><mark><span>  valueMissing: <span>false</span>;
</span></mark><span><span>}
</span></span></code></span><small id="shcb-language-4"><span>Code language:</span> <span>JSON / JSON with Comments</span> <span>(</span><span>json</span><span>)</span></small>
```

Above, the `valueMissing` property is now `false` (the `required` constraint is now satisfied), but the `typeMismatch` property flipped to `true` because “asdf” does not satisfy the `type="email"` validation constraint. The `valid` property is still `false`.

And that’s it! We were just handed the critical piece to the puzzle.

Accessing an input’s ValidityState object is the key to providing custom, more accessible validation messages, enhancing the user experience over the default generic messages that [may not be WCAG-compliant](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-2-layering-in-javascript/#have-the-error-message-accessibility-issues-been-addressed).

[Permalink to Let’s add more demo fields](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-4-custom-validation-messages/#lets-add-more-demo-fields)

## Let’s add more demo fields

We can add more demo fields to see different ValidityState properties in action. Below are the input fields I added to the demo…

URL:

```
<span><code id="code-lang-xml"><span>&lt;<span>input</span> 
  <span>name</span>=<span>"demoUrl"</span> 
  <span>type</span>=<span>"url"</span> 
  <span>required</span>
&gt;</span></code></span><small id="shcb-language-5"><span>Code language:</span> <span>HTML, XML</span> <span>(</span><span>xml</span><span>)</span></small>
```

Minimum three-character text value:

```
<span><code id="code-lang-xml"><span>&lt;<span>input</span> 
  <span>name</span>=<span>"demoTooShort"</span> 
  <span>type</span>=<span>"text"</span> 
  <span>minlength</span>=<span>"3"</span> 
  <span>required</span>
&gt;</span></code></span><small id="shcb-language-6"><span>Code language:</span> <span>HTML, XML</span> <span>(</span><span>xml</span><span>)</span></small>
```

Maximum five-character text value:

```
<span><code id="code-lang-xml"><span>&lt;<span>input</span> 
  <span>name</span>=<span>"demoTooLong"</span> 
  <span>type</span>=<span>"text"</span> 
  <span>maxlength</span>=<span>"5"</span> 
&gt;</span></code></span><small id="shcb-language-7"><span>Code language:</span> <span>HTML, XML</span> <span>(</span><span>xml</span><span>)</span></small>
```

Even number between 10 and 20:

```
<span><code id="code-lang-xml"><span>&lt;<span>input</span>
  <span>name</span>=<span>"demoRangeEven"</span> 
  <span>type</span>=<span>"number"</span> 
  <span>min</span>=<span>"10"</span> 
  <span>max</span>=<span>"20"</span> 
  <span>step</span>=<span>"2"</span> 
  <span>required</span>
&gt;</span></code></span><small id="shcb-language-8"><span>Code language:</span> <span>HTML, XML</span> <span>(</span><span>xml</span><span>)</span></small>
```

Odd number between 11 and 21:

```
<span><code id="code-lang-xml"><span>&lt;<span>input</span>
  <span>name</span>=<span>"demoRangeOdd"</span> 
  <span>type</span>=<span>"number"</span> 
  <span>min</span>=<span>"11"</span> 
  <span>max</span>=<span>"21"</span> 
  <span>step</span>=<span>"2"</span>
&gt;</span></code></span><small id="shcb-language-9"><span>Code language:</span> <span>HTML, XML</span> <span>(</span><span>xml</span><span>)</span></small>
```

Special 3-5 digit code:

```
<span><code id="code-lang-xml"><span>&lt;<span>input</span>
  <span>name</span>=<span>"demoPattern"</span> 
  <span>type</span>=<span>"text"</span> 
  <span>pattern</span>=<span>"[0-9]{3,5}"</span> 
  <span>minlength</span>=<span>"3"</span> 
  <span>maxlength</span>=<span>"5"</span>
&gt;</span></code></span><small id="shcb-language-10"><span>Code language:</span> <span>HTML, XML</span> <span>(</span><span>xml</span><span>)</span></small>
```

All of the new demo fields were added inside a new “More Demo Fields” `fieldset`:

![A "More Demo Fields" fieldset with a group of demo fields including "URL (required)", "Minimum three-character text value (required)", "Maximum five-character text value", "Even number between 10 and 20 (required)", "Odd number between 11 and 21", and "Special 3-5 digit code" fields.](https://cloudfour.com/wp-content/uploads/2023/08/Screen-Shot-2023-08-31-at-4.39.04-AM-689x1024.png)

A series of input fields with various validation constraints were added to the demo form.

[Permalink to Adding custom validation messages](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-4-custom-validation-messages/#adding-custom-validation-messages)

## Adding custom validation messages

Let’s create a new function, `getValidationMessageForInput`, to handle the custom validation message logic. It will accept an input element as the only argument and return a string:

```
<span><code id="code-lang-javascript"><span>/**
 * Returns a custom validation message referencing the input's ValidityState object.
 * <span>@param <span>{HTMLInputElement}</span> </span>inputEl The input element
 * <span>@returns <span>{string}</span> </span>A custom validation message for the given input element
 */</span>
<span>const</span> getValidationMessageForInput = <span>(<span>inputEl</span>) =&gt;</span> {
  <span>// Custom validation message logic will go here.</span>
}</code></span><small id="shcb-language-11"><span>Code language:</span> <span>JavaScript</span> <span>(</span><span>javascript</span><span>)</span></small>
```

To start with, we can return an empty string if the input’s ValidityState `valid` property is `true`:

```
<span><code id="code-lang-javascript"><span><span><span>const</span> getValidationMessageForInput = <span>(<span>inputEl</span>) =&gt;</span> {
</span></span><span><span>  <span>// If the input is valid, return an empty string.</span>
</span></span><mark><span>  <span>if</span> (inputEl.validity.valid) <span>return</span> <span>''</span>;
</span></mark><span><span>
</span></span><span><span>  <span>// The rest of the custom validation message logic will go here.</span>
</span></span><span><span>}
</span></span></code></span><small id="shcb-language-12"><span>Code language:</span> <span>JavaScript</span> <span>(</span><span>javascript</span><span>)</span></small>
```

For the rest of the custom validation message logic, we can consider a couple of different patterns. The first is to organize the messages by ValidityState property, for example, for the `valueMissing` property:

```
<span><code id="code-lang-javascript"><span><span><span>const</span> getValidationMessageForInput = <span>(<span>inputEl</span>) =&gt;</span> {
</span></span><span><span>  <span>// If the input is valid, return an empty string.</span>
</span></span><span><span>  <span>if</span> (inputEl.validity.valid) <span>return</span> <span>''</span>;
</span></span><span><span>
</span></span><mark><span>  <span>if</span> (inputEl.validity.valueMissing) {
</span></mark><mark><span>    <span>return</span> <span>'Please enter a value'</span>;
</span></mark><mark><span>  }
</span></mark><span><span>
</span></span><span><span>  <span>// The rest of the custom validation message logic goes here.</span>
</span></span><span><span>}
</span></span></code></span><small id="shcb-language-13"><span>Code language:</span> <span>JavaScript</span> <span>(</span><span>javascript</span><span>)</span></small>
```

While perhaps the most straightforward, this pattern is more limiting because we cannot craft field-specific messages; they will feel too generic. Let’s add an extra conditional check to organize them by input field `name` instead.

Using the [`customerEmail` example from above](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-4-custom-validation-messages/#validitystate-api-overview), we can do something like this:

```
<span><code id="code-lang-javascript"><span><span><span>const</span> getValidationMessageForInput = <span>(<span>inputEl</span>) =&gt;</span> {
</span></span><span><span>  <span>// If the input is valid, return an empty string.</span>
</span></span><span><span>  <span>if</span> (inputEl.validity.valid) <span>return</span> <span>''</span>;
</span></span><span><span>
</span></span><span><span>  <span>/**</span>
</span></span><span><span><span>   * Customer email validation constraints:</span>
</span></span><span><span><span>   * - required</span>
</span></span><span><span><span>   * - type=email</span>
</span></span><span><span><span>   */</span>
</span></span><mark><span>  <span>if</span> (inputEl.name === <span>'customerEmail'</span>) {
</span></mark><mark><span>    <span>if</span> (inputEl.validity.valueMissing) {
</span></mark><mark><span>      <span>return</span> <span>'Please enter an email address. (This field is required.)'</span>;
</span></mark><mark><span>    }
</span></mark><mark><span>    <span>if</span> (inputEl.validity.typeMismatch) {
</span></mark><mark><span>      <span>return</span> <span>'Please enter a valid email address.'</span>;
</span></mark><mark><span>    }
</span></mark><mark><span>  }
</span></mark><span><span>
</span></span><span><span>  <span>// The rest of the custom validation message logic goes here.</span>
</span></span><span><span>}
</span></span><span><span>
</span></span></code></span><small id="shcb-language-14"><span>Code language:</span> <span>JavaScript</span> <span>(</span><span>javascript</span><span>)</span></small>
```

Better! This pattern gives us the flexibility to write unique validation messages for each input field’s specific ValidityState property, for example:

```
<span><code id="code-lang-javascript"><span><span><span>/**</span>
</span></span><span><span><span> * Purchase date validation constraints:</span>
</span></span><span><span><span> * - required</span>
</span></span><span><span><span> * - type=date</span>
</span></span><span><span><span> * - min</span>
</span></span><span><span><span> * - max</span>
</span></span><span><span><span> */</span>
</span></span><span><span><span>if</span> (inputEl.name === <span>'purchaseDate'</span>) {
</span></span><mark><span>  <span>if</span> (inputEl.validity.valueMissing) {
</span></mark><span><span>    <span>return</span> <span>'Please enter a purchase date. (This field is required.)'</span>;
</span></span><span><span>  }
</span></span><mark><span>  <span>if</span> (inputEl.validity.typeMismatch) {
</span></mark><span><span>    <span>return</span> <span>'Please enter a valid purchase date.'</span>;
</span></span><span><span>  }
</span></span><mark><span>  <span>if</span> (inputEl.validity.rangeUnderflow) {
</span></mark><span><span>    <span>return</span> <span>'The purchase date must be within the last calendar year.'</span>;
</span></span><span><span>  }
</span></span><mark><span>  <span>if</span> (inputEl.validity.rangeOverflow) {
</span></mark><span><span>    <span>return</span> <span>'The purchase date cannot be a future date.'</span>;
</span></span><span><span>  }
</span></span><span><span>}
</span></span></code></span><small id="shcb-language-15"><span>Code language:</span> <span>JavaScript</span> <span>(</span><span>javascript</span><span>)</span></small>
```

If we don’t want unique validation messages for each ValidityState property, we can collapse multiple property checks into a single conditional and return only one validation message:

```
<span><code id="code-lang-javascript"><span><span><span>/**</span>
</span></span><span><span><span> * "Odd number between 11 and 21" validation constraints:</span>
</span></span><span><span><span> * - type=number</span>
</span></span><span><span><span> * - min</span>
</span></span><span><span><span> * - max</span>
</span></span><span><span><span> * - step</span>
</span></span><span><span><span> */</span>
</span></span><span><span><span>if</span> (inputEl.name === <span>'demoRangeOdd'</span>) {
</span></span><span><span>  <span>if</span> (inputEl.validity.valueMissing) {
</span></span><span><span>    <span>return</span> <span>'Please enter a number. (This field is required.)'</span>;
</span></span><span><span>  }
</span></span><span><span>  <span>if</span> (inputEl.validity.badInput) {
</span></span><span><span>    <span>return</span> <span>'Please enter a valid number value.'</span>;
</span></span><span><span>  }
</span></span><mark><span>  <span>if</span> (
</span></mark><mark><span>    inputEl.validity.rangeUnderflow ||
</span></mark><mark><span>    inputEl.validity.rangeOverflow ||
</span></mark><mark><span>    inputEl.validity.stepMismatch
</span></mark><mark><span>  ) {
</span></mark><span><span>    <span>return</span> <span>`The value should be an odd number between <span>${</span></span>
</span></span><span><span><span><span>      inputEl.getAttribute(<span>'min'</span>)</span></span>
</span></span><span><span><span><span>    }</span> and <span>${</span></span>
</span></span><span><span><span><span>      inputEl.getAttribute(<span>'max'</span>)</span></span>
</span></span><span><span><span><span>    }</span>.`</span>;
</span></span><span><span>  }
</span></span><span><span>}
</span></span></code></span><small id="shcb-language-16"><span>Code language:</span> <span>JavaScript</span> <span>(</span><span>javascript</span><span>)</span></small>
```

You’ll notice you can even use the literal input attribute values within the validation messages if it makes sense, as I did above, using the input’s `min` and `max` attribute values:

```
<span><code id="code-lang-javascript"><span><span><span>return</span> <span>`The value should be an odd number between <span>${</span></span>
</span></span><mark><span><span><span>  inputEl.getAttribute(<span>'min'</span>)</span></span>
</span></mark><span><span><span><span>}</span> and <span>${</span></span>
</span></span><mark><span><span><span>  inputEl.getAttribute(<span>'max'</span>)</span></span>
</span></mark><span><span><span><span>}</span>.`</span>;
</span></span></code></span><small id="shcb-language-17"><span>Code language:</span> <span>JavaScript</span> <span>(</span><span>javascript</span><span>)</span></small>
```

This would generate the following validation error message:

> The value should be an odd number between 11 and 21.

![The "Odd number between 11 and 21" field with a value of 9 showing the invalid UI state with a validation message: "The value should be an odd number between 11 and 21."](https://cloudfour.com/wp-content/uploads/2023/08/Screen-Shot-2023-08-31-at-4.45.30-AM-1024x955.png)

For the “Odd number between 11 and 21” number input field, if a value does not meet the `min`, `max`, or `step` validation constraints, the validation message “The value should be an odd number between 11 and 21” displays.

We’ll apply this pattern, organizing the messages by input field `name`, for the rest of the form fields. I won’t include them all here, but you can peek at the [`getValidationMessageForInput` source code file](https://github.com/cloudfour/constraint-validation-api-demo/blob/main/src/form-validation/get-validity-message-for-input.js) if you want to see them all.

The only other addition we should make is a fallback message if no conditionals match. At the bottom of the function, we can return the [built-in `validationMessage`](https://web.dev/constraintvalidation/#validationmessage) as the fallback message:

```
<span><code id="code-lang-javascript"><span><span><span>const</span> getValidationMessageForInput = <span>(<span>inputEl</span>) =&gt;</span> {
</span></span><span><span>  <span>// If the input is valid, return an empty string.</span>
</span></span><span><span>  <span>if</span> (inputEl.validity.valid) <span>return</span> <span>''</span>;
</span></span><span><span>
</span></span><span><span>  <span>if</span> (inputEl.name === <span>'customerEmail'</span>) { 
</span></span><span><span>    <span>// Custom validation messages for customer email.</span>
</span></span><span><span>  }
</span></span><span><span>
</span></span><span><span>  <span>if</span> (inputEl.name === <span>'purchaseDate'</span>) {
</span></span><span><span>    <span>// Custom validation messages for purchase date here.</span>
</span></span><span><span>  }
</span></span><span><span>
</span></span><span><span>  <span>// Follow the same pattern for the rest of the input fields.</span>
</span></span><span><span> 
</span></span><span><span>  <span>// If all else fails, return the default built-in message.</span>
</span></span><mark><span>  <span>return</span> inputEl.validationMessage;
</span></mark><span><span>}
</span></span></code></span><small id="shcb-language-18"><span>Code language:</span> <span>JavaScript</span> <span>(</span><span>javascript</span><span>)</span></small>
```

[Permalink to Updating the demo to use custom validation messages](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-4-custom-validation-messages/#updating-the-demo-to-use-custom-validation-messages)

## Updating the demo to use custom validation messages

Alright, it’s time for the _real_ heavy lifting…_just kidding!_ Lucky for us, updating our demo to use our new custom validation messages means only updating a single line in our existing code.

In the [`updateValidationStateForInput` function introduced in Part 2](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-2-layering-in-javascript/#using-the-constraint-validation-api-to-validate-and-update-the-ui-state), change the `errorEl.textContent` value from `inputEl.validationMessage` (the browser’s default generic messages) to our new `getValidationMessageForInput` function:

```
<span><code id="code-lang-diff">const updateValidationStateForInput = (inputEl) =&gt; {
  // Existing code from Part 2 here…

<span>-  // Use the browser's built-in localized validation messages. </span>
<span>-  errorEl.textContent = inputEl.validationMessage</span>
<span>+  // Use custom validation messages.</span>
<span>+  errorEl.textContent = getValidationMessageForInput(inputEl)</span>
};</code></span><small id="shcb-language-20"><span>Code language:</span> <span>Diff</span> <span>(</span><span>diff</span><span>)</span></small>
```

All done! The new customized validation messages can now flow right into the existing experience.

Below you can see a few of the custom validation messages in action (or you can [view the live demo](https://constraint-validation-api-demo.netlify.app/part-4/)):

The first name, last name, and email fields with custom validation messages.

The new demo fields with custom validation messages.

[Permalink to What about localized validation messages?](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-4-custom-validation-messages/#what-about-localized-validation-messages)

## What about localized validation messages?

If we recall from Part 2, we previously used the [input element’s `validationMessage` property](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-2-layering-in-javascript/#what-is-the-validationmessage-property) for the “error” element `textContent` value. This ensured we received a built-in _localized_ validation message.

With custom validation messages instead, it begs the question, are the validation messages no longer localized?

As it turns out, all evergreen browsers _can_ translate our new custom validation messages! I tested the following browsers:

-   Safari (using the [Safari Translate button](https://support.apple.com/guide/safari/translate-a-webpage-ibrw646b2ca2/mac))
-   Firefox (using the [Firefox Translations extension](https://addons.mozilla.org/en-US/firefox/addon/firefox-translations/))
-   Chrome (using the [Chrome Translate feature](https://support.google.com/chrome/answer/173424?hl=en&co=GENIE.Platform%3DDesktop))
-   Edge (using the [Microsoft Edge Translate icon](https://support.microsoft.com/en-us/topic/use-microsoft-translator-in-microsoft-edge-browser-4ad1c6cb-01a4-4227-be9d-a81e127fcb0b))

For example, below, I recorded Safari translating the demo into Spanish. You’ll notice the browser translates the custom validation messages as they update for the “URL” and “Minimum three-character text value” fields:

Safari (shown in the video), Firefox, Chrome, and Edge will all translate the custom validation messages as they are updated using their built-in translation features.

All browsers I tested provided a similar experience, including the millisecond moment when the English message shows before the browser translates it. It’s a bit annoying, but it makes sense that the text needs to make it into the DOM for the browser to translate it.

When I tested with VoiceOver + Safari, the screen reader would only announce the translated version.

If the browser translation features are insufficient for your project needs, you can look into implementing a more in-depth localization strategy. Here are a couple of articles that might be helpful, “[How to conduct website localization: Don’t get lost in translation](https://www.smashingmagazine.com/2014/12/how-to-conduct-website-localization/)” by Julia Rozwens and “[Internationalization and localization for static sites](https://www.smashingmagazine.com/2020/11/internationalization-localization-static-sites/)” by Sam Richard.

[Permalink to Wrapping up](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-4-custom-validation-messages/#wrapping-up)

## Wrapping up

We did it! We learned about the ValidityState API and how we can use it to write custom, accessible validation messages. The best, most inclusive user experiences are a balance between technical implementations and human end-user considerations. [User needs come first](https://cloudfour.com/thinks/the-design-system-priority-of-constituencies/).

Thanks for following along with the article series. It was a joy exploring how to enhance the form validation experience progressively. Until next time!

[Permalink to More resources](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-4-custom-validation-messages/#more-resources)

## More resources

-   [When life gives you lemons, write better error messages](https://wix-ux.com/when-life-gives-you-lemons-write-better-error-messages-46c5223e1a2f) by Jenni Nadler
-   [Designing Better Error Messages UX: Establish Stop-Words For Your Error Messages](https://www.smashingmagazine.com/2022/08/error-messages-ux-design/#establish-stop-words-for-your-error-messages) by Vitaly Friedman
-   [Harvard University: Provide helpful error messages](https://accessibility.huit.harvard.edu/provide-helpful-error-messages)
-   [Accessible Web: How should I write form error messages?](https://accessibleweb.com/question-answer/how-should-i-write-form-error-messages/)
-   [Curious about the `type="email"` basic validation regular expression used by browsers?](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/email#basic_validation)
-   Need more restrictive email validation? [Add the `pattern` attribute to `email` input types](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/email#pattern_validation).
-   Shoutout to Chris Ferdinandi, who wrote an [article using the ValidityState API a few years ago](https://css-tricks.com/form-validation-part-2-constraint-validation-api-javascript/); great minds think alike. 😉

[Permalink to Missed an article in the series?](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-4-custom-validation-messages/#missed-an-article-in-the-series)

## Missed an article in the series?

I’ve got you! Listed below are all of the articles from the series:

-   [Part 1: HTML and CSS](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-1-html-and-css/)
-   [Part 2: Layering in JavaScript](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-2-layering-in-javascript/)
-   [Part 3: Validating a checkbox group](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-3-validating-a-checkbox-group/)
-   [Part 4: Custom validation messages](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-4-custom-validation-messages/)
