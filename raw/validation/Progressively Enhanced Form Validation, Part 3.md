---
created: 2024-09-24T13:19:57 (UTC -04:00)
tags: []
source: https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-3-validating-a-checkbox-group/
author: Gerardo Rodriguez
---

# Progressively Enhanced Form Validation, Part 3: Validating a checkbox group – Cloud Four

> ## Excerpt
> Parts 1 and 2 of this series explore the browser's built-in HTML & CSS form validation features and how to progressively enhance the experience by layering in JavaScript. This article continues the exploration, focusing on a use case not handled natively: a checkbox group.

---
![Three icons. Icon 1: representing an invalid state, a fuscia circle shape with a white exclamation mark in the center. Icon 2: representing a valid state, a green circle shape with a white checkmark in the center. Icon 3: square representing a checkbox group.](https://cloudfour.com/wp-content/uploads/2023/08/part3-1-1024x576.png)

[Part 1](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-1-html-and-css/) and [Part 2](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-2-layering-in-javascript/) of this series explore the browser’s built-in HTML and CSS form validation features and how to progressively enhance the experience by layering JavaScript using the Constraint Validation API.

This article extends that exploration by focusing on a form validation use case that is not handled by the browser’s native validation features: [a `checkbox` group](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/checkbox#handling_multiple_checkboxes).

Feel free to view the [demo for this article](https://constraint-validation-api-demo.netlify.app/part-3/) as a reference. The [source code is available on GitHub](https://github.com/cloudfour/constraint-validation-api-demo).

A checkbox group is a series of `checkbox` input types with the same `name` attribute value. For example, below is a simplified version of the “interests” checkbox group from the demo:

```
<span><code id="code-lang-xml"><span>&lt;<span>fieldset</span>&gt;</span>
  <span>&lt;<span>legend</span>&gt;</span>Interests <span>&lt;<span>span</span>&gt;</span>(required)<span>&lt;/<span>span</span>&gt;</span><span>&lt;/<span>legend</span>&gt;</span>
  <span>&lt;<span>input</span> <span>id</span>=<span>"coding"</span> <span>type</span>=<span>"checkbox"</span> <span>name</span>=<span>"interests"</span> <span>value</span>=<span>"coding"</span> /&gt;</span>
  <span>&lt;<span>label</span> <span>for</span>=<span>"coding"</span>&gt;</span>Coding<span>&lt;/<span>label</span>&gt;</span>
  <span>&lt;<span>input</span> <span>id</span>=<span>"music"</span> <span>type</span>=<span>"checkbox"</span> <span>name</span>=<span>"interests"</span> <span>value</span>=<span>"music"</span> /&gt;</span>
  <span>&lt;<span>label</span> <span>for</span>=<span>"music"</span>&gt;</span>Music<span>&lt;/<span>label</span>&gt;</span>
  <span>&lt;<span>input</span> <span>id</span>=<span>"art"</span> <span>type</span>=<span>"checkbox"</span> <span>name</span>=<span>"interests"</span> <span>value</span>=<span>"art"</span> /&gt;</span>
  <span>&lt;<span>label</span> <span>for</span>=<span>"art"</span>&gt;</span>Art<span>&lt;/<span>label</span>&gt;</span>
  <span>&lt;<span>input</span> <span>id</span>=<span>"sports"</span> <span>type</span>=<span>"checkbox"</span> <span>name</span>=<span>"interests"</span> <span>value</span>=<span>"sports"</span> /&gt;</span>
  <span>&lt;<span>label</span> <span>for</span>=<span>"sports"</span>&gt;</span>Sports<span>&lt;/<span>label</span>&gt;</span>
<span>&lt;/<span>fieldset</span>&gt;</span></code></span><small id="shcb-language-1"><span>Code language:</span> <span>HTML, XML</span> <span>(</span><span>xml</span><span>)</span></small>
```

Notice that a `fieldset` element wraps the checkboxes and includes a `legend` describing the group. It’s a good practice to wrap a group of checkboxes (or any related form elements) in a `fieldset` element as it improves semantics, accessibility, and visual organization.

![A group of checkbox inputs, labelled "Interests (required)". The checkbox input options are Coding, Music, Art, and Sports. No checkboxes are selected.](https://cloudfour.com/wp-content/uploads/2023/08/Screen-Shot-2023-08-31-at-5.14.33-AM-1024x814.png)

An “interests” checkbox group requires JavaScript for validation.

[Unlike a radio group](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/radio#required), there isn’t a native HTML validation feature to mark a checkbox group as “required” (where at least one checkbox must be selected). Since we cannot validate using browser built-in features, we’ll need to add custom JavaScript.

For this demo, we’ll focus on the following:

1.  [Implementing the real-time validation pattern](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-3-validating-a-checkbox-group/#implementing-the-real-time-validation-pattern): Validate when any checkbox within the group is checked/unchecked
2.  [Implementing the late validation pattern](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-3-validating-a-checkbox-group/#implementing-the-late-validation-pattern): Validate when the group loses focus when keyboard tabbing through the interface
3.  [Adding the validation logic](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-3-validating-a-checkbox-group/#adding-the-validation-logic): At least one interest must be selected from the group
4.  [Toggling the checkbox visual validation state](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-3-validating-a-checkbox-group/#toggling-the-checkbox-visual-validation-state): Toggle `is-invalid`/`is-valid` CSS classes appropriately
5.  [Adding an accessible custom error message](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-3-validating-a-checkbox-group/#adding-an-accessible-custom-error-message): Show a custom error message when applicable
6.  [Adding a group validation state icon and `aria-invalid` value](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-3-validating-a-checkbox-group/#adding-a-group-validation-state-icon-and-aria-invalid-value): Individual icons per checkbox don’t make sense; consider accessibility
7.  [Hooking into the existing form submit handler](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-3-validating-a-checkbox-group/#hooking-into-the-existing-form-submit-handler): Use the existing `onSubmit` handler flow
8.  [Include the checkbox group in the “first invalid input” focus](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-3-validating-a-checkbox-group/#include-the-checkbox-group-in-the-first-invalid-input-focus): Automatically set focus to the group when the form is submitted if it’s the first invalid “input”
9.  [Selectively validate the checkbox group on page load](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-3-validating-a-checkbox-group/#selectively-validate-the-checkbox-group-on-page-load): Handle if a checkbox is checked on page load

There may be room for improvement, but implementing the above requirements provides a solid, enhanced experience when JavaScript is available.

Let’s dive in!

[Permalink to Implementing the real-time validation pattern](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-3-validating-a-checkbox-group/#implementing-the-real-time-validation-pattern)

## Implementing the real-time validation pattern

Let’s start adding some JavaScript. We’ll begin by adding a function, `validateInterestsCheckboxGroup`, that we can call to validate the group of checkboxes (we’ll fill in this function’s logic shortly). The function will accept the `form` element as an argument:

```
<span><code id="code-lang-javascript"><span><span><span>/**</span>
</span></span><span><span><span> * Validates the "interests" checkbox group.</span>
</span></span><span><span><span> * Custom validation is required because checkbox group validation </span>
</span></span><span><span><span> * is not supported by the browser's built-in validation features.</span>
</span></span><span><span><span> * <span>@param <span>{HTMLFormElement}</span> </span>formEl The form element</span>
</span></span><span><span><span><span> * <span>@return <span>{boolean}</span> </span>Is the "interests" checkbox group valid?</span></span>
</span></span><span><span><span><span><span> */</span></span></span>
</span></span><mark><span><span><span><span>const</span> validateInterestsCheckboxGroup = <span>(<span>formEl</span>) =&gt;</span> {</span></span>
</span></mark><span><span><span><span><span>  </span></span></span>
</span></span><span><span><span><span><span>}</span></span></span>
</span></span></code></span><small id="shcb-language-3"><span>Code language:</span> <span>JavaScript</span> <span>(</span><span>javascript</span><span>)</span></small>
```

Now let’s set up the `change` event listener to hook up real-time validation ([a live validation pattern](https://www.smashingmagazine.com/2022/09/inline-validation-web-forms-ux/)).

We can add the `change` event listener code in the [`init` function introduced in Part 2](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-2-layering-in-javascript/#removing-invalid-styles-on-page-load-for-all-browsers) so it can initialize with the rest of the form validation logic:

-   Select all inputs with a `name` value of “interests” (the checkboxes)
-   For each checkbox input, add a `change` event listener with `validateInterestsCheckboxGroup` as the callback function
-   Make sure to pass along the `formEl` as the argument

```
<span><code id="code-lang-javascript"><span><span><span>/**</span>
</span></span><span><span><span> * Initialize validation setup</span>
</span></span><span><span><span> */</span>
</span></span><span><span><span>const</span> init = <span><span>()</span> =&gt;</span> {
</span></span><span><span>  <span>const</span> formEl = <span>document</span>.querySelector(<span>'#demo-form'</span>);
</span></span><span><span>
</span></span><span><span>  <span>// Existing code from Part 2 here…</span>
</span></span><span><span>
</span></span><span><span>  <span>// Set up event listeners to validate the "interests" checkbox group.</span>
</span></span><mark><span>  <span>document</span>
</span></mark><mark><span>    .querySelectorAll(<span>'input[name="interests"]'</span>)
</span></mark><mark><span>    .forEach(<span>(<span>checkboxInputEl</span>) =&gt;</span> {
</span></mark><span><span>      <span>// Updates the UI state for the checkbox group when checked/unchecked</span>
</span></span><mark><span>      checkboxInputEl.addEventListener(<span>'change'</span>, () =&gt;
</span></mark><mark><span>        validateInterestsCheckboxGroup(formEl)
</span></mark><mark><span>      );
</span></mark><span><span>    });
</span></span><span><span>};
</span></span><span><span>
</span></span></code></span><small id="shcb-language-4"><span>Code language:</span> <span>JavaScript</span> <span>(</span><span>javascript</span><span>)</span></small>
```

[Permalink to Thoughtful consideration when adding real-time validation](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-3-validating-a-checkbox-group/#thoughtful-consideration-when-adding-real-time-validation)

### Thoughtful consideration when adding real-time validation

As [previously noted](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-2-layering-in-javascript/#a-note-on-real-time-validation), carefully consider when adding real-time validation, as not all users appreciate live validation feedback. A group of checkboxes is a more appropriate use case for real-time validation since after a single action (press/click), the user is “done” checking or unchecking the input, unlike a `text` input where a single action (typing one character) may not complete the user’s full intent.

To test things are working, we can add a `console.log` in the `validateInterestsCheckboxGroup` function we created above:

```
<span><code id="code-lang-javascript"><span><span><span>const</span> validateInterestsCheckboxGroup = <span>(<span>formEl</span>) =&gt;</span> {
</span></span><mark><span>  <span>console</span>.log(<span>'Validate the "interests" checkbox group'</span>);
</span></mark><span><span>}
</span></span></code></span><small id="shcb-language-5"><span>Code language:</span> <span>JavaScript</span> <span>(</span><span>javascript</span><span>)</span></small>
```

Selecting/unselecting any “interests” checkbox triggers the `console.log` message.

Fantastic, the correct wires are connected! This sets us up to validate the group when any checkboxes are checked or unchecked.

[Permalink to Implementing the late validation pattern](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-3-validating-a-checkbox-group/#implementing-the-late-validation-pattern)

## Implementing the late validation pattern

Per our requirements above, when navigating through the interface with a keyboard, the checkbox group should be validated when a user tabs _out_ of the group. This [live validation](https://www.smashingmagazine.com/2022/09/inline-validation-web-forms-ux/) pattern is known as “late validation.”

Setting up the late validation pattern requires a touch of extra logic for a group of checkboxes. For example, if it were a single checkbox input, we’d want the validation to happen immediately when the single checkbox’s `blur` event fires. However, we only want the validation to run for a checkbox group when the focus has left the group.

The following logic gets us what we need:

-   Add a `blur` event to each of the checkbox inputs in the group
-   On `blur`, check the `FocusEvent.relatedTarget` to see if it is one of the checkboxes
-   If it is not one of the checkboxes, run the validation

For a `blur` event, the `[FocusEvent.relatedTarget](https://developer.mozilla.org/en-US/docs/Web/API/FocusEvent/relatedTarget)` is the element _receiving_ focus (the `[EventTarget](https://developer.mozilla.org/en-US/docs/Web/API/EventTarget)`). In our case, we can use this to tell if the element receiving focus is or is not one of the “interests” checkbox inputs.

We can add the `blur` logic alongside the previously added `change` event listener:

```
<span><code id="code-lang-javascript"><span><span><span>const</span> init = <span><span>()</span> =&gt;</span> {
</span></span><span><span>  <span>const</span> formEl = <span>document</span>.querySelector(<span>'#demo-form'</span>);
</span></span><span><span>
</span></span><span><span>  <span>// Existing code from Part 2 here…</span>
</span></span><span><span>
</span></span><span><span>  <span>// Set up event listeners to validate the "interests" checkbox group.</span>
</span></span><span><span>  <span>document</span>
</span></span><span><span>    .querySelectorAll(<span>'input[name="interests"]'</span>)
</span></span><span><span>    .forEach(<span>(<span>checkboxInputEl</span>) =&gt;</span> {
</span></span><span><span>      <span>// Updates the UI state for the checkbox group when checked/unchecked</span>
</span></span><span><span>      checkboxInputEl.addEventListener(<span>'change'</span>, () =&gt;
</span></span><span><span>        validateInterestsCheckboxGroup(formEl)
</span></span><span><span>      );
</span></span><span><span>      <span>// Set up late validation for the checkbox group</span>
</span></span><mark><span>      checkboxInputEl.addEventListener(<span>'blur'</span>, (event) =&gt; {
</span></mark><span><span>        <span>// FocusEvent.relatedTarget is the element receiving focus.</span>
</span></span><mark><span>        <span>const</span> activeEl = event.relatedTarget;
</span></mark><span><span>        <span>// Validate only if the focus is not going to another checkbox.</span>
</span></span><mark><span>        <span>if</span> (activeEl?.getAttribute(<span>'name'</span>) !== <span>'interests'</span>) {
</span></mark><mark><span>          validateInterestsCheckboxGroup(formEl);
</span></mark><mark><span>        }
</span></mark><span><span>      });
</span></span><span><span>    });
</span></span><span><span>};
</span></span><span><span>
</span></span></code></span><small id="shcb-language-6"><span>Code language:</span> <span>JavaScript</span> <span>(</span><span>javascript</span><span>)</span></small>
```

Excellent! That wasn’t _terrible_ to figure out (props to [Paul Hebert](https://cloudfour.com/is/paul/) for pointing me to the [`FocusEvent.relatedTarget` MDN docs](https://developer.mozilla.org/en-US/docs/Web/API/FocusEvent/relatedTarget) 🙂).

Below, notice the `console.log` message prints only when the focus leaves the group of checkboxes (and not when tabbing between the checkbox inputs):

The checkbox group validation only runs when the focus leaves the group.

[Permalink to Adding the validation logic](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-3-validating-a-checkbox-group/#adding-the-validation-logic)

## Adding the validation logic

We can now add the code to validate the checkbox group inside the `validateInterestsCheckboxGroup` function. The logic will be as follows:

-   Use the `getAll` method from the `FormData` API to confirm at least one checkbox is checked
-   Use the result to return a boolean representing the “Is the checkbox group valid?” state

[Permalink to What is the `FormData` API?](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-3-validating-a-checkbox-group/#what-is-the-formdata-api)

### What is the `FormData` API?

The [`FormData` API](https://developer.mozilla.org/en-US/docs/Web/API/FormData) provides a concise way to interact with field values from an HTML form. The API feels intuitive and is [well-supported](https://caniuse.com/mdn-api_formdata). For example, the [`FormData.getAll` method](https://developer.mozilla.org/en-US/docs/Web/API/FormData/getAll) returns an array of all the values for a given key, an excellent choice for a checkbox group.

**Note:** Input fields must have a `name` attribute to be retrieved by the `FormData` API.

Replace the `console.log` with the following logic:

```
<span><code id="code-lang-javascript"><span><span><span>const</span> validateInterestsCheckboxGroup = <span>(<span>formEl</span>) =&gt;</span> {
</span></span><span><span>  <span>// Are any of the "interests" checkboxes checked? </span>
</span></span><span><span>  <span>// At least one is required.</span>
</span></span><mark><span>  <span>const</span> formData = <span>new</span> FormData(formEl);
</span></mark><mark><span>  <span>const</span> isValid = formData.getAll(<span>'interests'</span>).length &gt; <span>0</span>;
</span></mark><span><span>
</span></span><span><span>  <span>// Return the validation state.</span>
</span></span><mark><span>  <span>return</span> isValid;
</span></mark><span><span>}
</span></span></code></span><small id="shcb-language-7"><span>Code language:</span> <span>JavaScript</span> <span>(</span><span>javascript</span><span>)</span></small>
```

Not too bad! We now have the checkbox group logic to drive the rest of the validation experience.

[Permalink to Toggling the checkbox visual validation state](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-3-validating-a-checkbox-group/#toggling-the-checkbox-visual-validation-state)

## Toggling the checkbox visual validation state

With the validation logic in place, we can leverage it to provide visual feedback. In the `validateInterestsCheckboxGroup` function, we’ll want to:

-   Select all of the “interests” checkboxes
-   Reference the `isValid` boolean to toggle `is-invalid`/`is-valid` CSS classes for each checkbox

```
<span><code id="code-lang-javascript"><span><span><span>const</span> validateInterestsCheckboxGroup = <span>(<span>formEl</span>) =&gt;</span> {
</span></span><span><span>  <span>// Code from above here…</span>
</span></span><span><span>
</span></span><span><span>  <span>// Get all the "interests" checkboxes.</span>
</span></span><mark><span>  <span>const</span> interestsCheckboxInputEls = <span>document</span>.querySelectorAll(
</span></mark><mark><span>    <span>'input[name="interests"]'</span>
</span></mark><mark><span>  );
</span></mark><span><span>
</span></span><span><span>  <span>// Update the validation UI state for each checkbox.</span>
</span></span><mark><span>  interestsCheckboxInputEls.forEach(<span>(<span>checkboxInputEl</span>) =&gt;</span> {
</span></mark><mark><span>    checkboxInputEl.classList.toggle(<span>'is-valid'</span>, isValid);
</span></mark><mark><span>    checkboxInputEl.classList.toggle(<span>'is-invalid'</span>, !isValid);
</span></mark><mark><span>  });
</span></mark><span><span>
</span></span><span><span>  <span>// Return the validation state.</span>
</span></span><span><span>  <span>return</span> isValid;
</span></span><span><span>}
</span></span></code></span><small id="shcb-language-8"><span>Code language:</span> <span>JavaScript</span> <span>(</span><span>javascript</span><span>)</span></small>
```

With that in place, the checkboxes’ visual validation state now updates. Hooray!

Below you can see the [real-time validation](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-3-validating-a-checkbox-group/#implement-real-time-validation-pattern) pattern in action. Notice the checkbox border color changes between a “valid” (green) and “invalid” (red) state when checked/unchecked:

The checkboxes toggle their visual “valid”/”invalid” state when checked or unchecked.

The [late validation](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-3-validating-a-checkbox-group/#implement-late-validation-pattern) pattern is now also updated visually. The border color for all of the checkboxes renders the “invalid” (red) state when the keyboard focus leaves the group if no checkbox was selected:

The border of the checkboxes in the group turns red when the focus leaves the group if no checkboxes are checked.

[Permalink to Adding an accessible custom error message](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-3-validating-a-checkbox-group/#adding-an-accessible-custom-error-message)

## Adding an accessible custom error message

In Part 2, we created a [more accessible experience by adding an `aria-describedby` attribute](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-2-layering-in-javascript/#using-a-custom-design-for-validation-error-messages) on the individual inputs pointing to the ID of their respective error message elements.

We need to use a different pattern for the checkbox group because we want to associate the error message with the group as a whole.

The pattern we’ll implement includes injecting the error message into the `legend` element. When using a screen reader, for example, the validation feedback will be incorporated when the screen reader reads the `legend`.

While this pattern is a bit more complicated, it was the most inclusive pattern I could find based on my research which also included reaching out to the [web-a11y.slack.com](https://web-a11y.slack.com/) community. Theoretically, the pattern could be simplified by only adding an `aria-describedby` attribute to the `fieldset` element, but unfortunately, there is an [NVDA bug](https://github.com/nvaccess/nvda/issues/12718) where the `aria-describedby` attribute is not respected for a checkbox group. A helpful resource for me was a great article by Tenon, “[Accessible validation of checkbox and radiobutton groups](https://blog.tenon.io/accessible-validation-of-checkbox-and-radiobutton-groups/),” where they explore various checkbox group validation patterns.

Let’s start with the HTML updates, which include adding some ARIA attributes:

-   **In the `fieldset` element**: Add an `aria-required` attribute to provide extra feedback when using assistive technologies like a screen reader
-   **In the `legend` element**: Add an `aria-hidden` attribute to the “(required)” text
    -   This “required” text provides visual feedback but is redundant when using assistive technology devices

We’ll also be adding two empty error message elements; one that assistive technologies will pick up (visually hidden) and one for users who are sighted (visible but hidden from assistive technologies):

-   **First empty error message element**: Place it inside the `legend`
    -   Visually hide the element via a [`visually-hidden` CSS class](https://www.a11yproject.com/posts/how-to-hide-content/)
    -   Includes a `js-interests-legend-error` CSS class to attach JavaScript logic
-   **Second empty error message element**: Place it below the last checkbox input
    -   Has `hidden` attribute as the default state
    -   Hidden from assistive technologies via `aria-hidden` attribute so duplicate error messages aren’t conveyed
    -   Includes a `js-interests-visual-error` CSS class to attach JavaScript logic

[Permalink to Why two error message elements?](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-3-validating-a-checkbox-group/#why-two-error-message-elements)

### Why two error message elements?

Adding two error message elements may seem redundant, but there’s a good reason. We add the **first empty error message element** within the `legend` element so that assistive technologies, like screen readers, can associate the error message with the checkbox group. But that doesn’t match our visual design, so we visually hide it. The **second empty error message element** is added to match the visual design; we hide it from assistive technologies so the error message doesn’t get conveyed twice.

```
<span><code id="code-lang-xml"><mark><span><span>&lt;<span>fieldset</span> <span>aria-required</span>=<span>"true"</span>&gt;</span>
</span></mark><span><span>  <span>&lt;<span>legend</span>&gt;</span>
</span></span><mark><span>    Interests <span>&lt;<span>span</span> <span>aria-hidden</span>=<span>"true"</span>&gt;</span>(required)<span>&lt;/<span>span</span>&gt;</span>
</span></mark><mark><span>    <span>&lt;<span>span</span> <span>class</span>=<span>"visually-hidden js-interests-legend-error"</span>&gt;</span>
</span></mark><mark><span>      <span>&lt;!-- Text content set by JS --&gt;</span>
</span></mark><mark><span>    <span>&lt;/<span>span</span>&gt;</span>
</span></mark><span><span>  <span>&lt;/<span>legend</span>&gt;</span>
</span></span><span><span>  <span>&lt;<span>div</span> <span>class</span>=<span>"field-wrapper checkbox-field-wrapper"</span>&gt;</span>
</span></span><span><span>    <span>&lt;!-- </span>
</span></span><span><span><span>      Checkboxes and label elements here… </span>
</span></span><span><span><span>    --&gt;</span>
</span></span><mark><span>    <span>&lt;<span>p</span> <span>hidden</span> <span>aria-hidden</span>=<span>"true"</span> <span>class</span>=<span>js-interests-visual-error</span>"&gt;</span>
</span></mark><mark><span>      <span>&lt;!-- Text content set by JS --&gt;</span>
</span></mark><mark><span>    <span>&lt;/<span>p</span>&gt;</span>
</span></mark><span><span>  <span>&lt;/<span>div</span>&gt;</span>
</span></span><span><span><span>&lt;/<span>fieldset</span>&gt;</span>
</span></span></code></span><small id="shcb-language-9"><span>Code language:</span> <span>HTML, XML</span> <span>(</span><span>xml</span><span>)</span></small>
```

In the JavaScript, we can update the `validateInterestsCheckboxGroup` function as follows:

-   Get both empty error message elements via their `js-*` classes
-   Set the error message depending on the `isValid` boolean
-   Toggle the `hidden` attribute on the visible error element accordingly

```
<span><code id="code-lang-javascript"><span><span><span>const</span> validateInterestsCheckboxGroup = <span>(<span>formEl</span>) =&gt;</span> {
</span></span><span><span>  <span>// Existing code from above here…</span>
</span></span><span><span>
</span></span><span><span>  <span>// Get both the legend and visual error message elements.</span>
</span></span><mark><span>  <span>const</span> legendErrorEl = <span>document</span>.querySelector(<span>'.js-interests-legend-error'</span>);
</span></mark><mark><span>  <span>const</span> visualErrorEl = <span>document</span>.querySelector(<span>'.js-interests-visual-error'</span>);
</span></mark><span><span>
</span></span><span><span>  <span>// Update the validation error message.</span>
</span></span><mark><span>  <span>const</span> errorMsg = isValid ? <span>''</span> : <span>'Select at least one interest.'</span>;
</span></mark><span><span>
</span></span><span><span>  <span>// Set the error message for both the legend and the visual error.</span>
</span></span><mark><span>  legendErrorEl.textContent = errorMsg;
</span></mark><mark><span>  visualErrorEl.textContent = errorMsg;
</span></mark><span><span>
</span></span><span><span>  <span>// Show/hide the visual error message depending on validity.</span>
</span></span><mark><span>  visualErrorEl.hidden = isValid;
</span></mark><span><span>
</span></span><span><span>  <span>// Return the validation state.</span>
</span></span><span><span>  <span>return</span> isValid;
</span></span><span><span>}
</span></span></code></span><small id="shcb-language-10"><span>Code language:</span> <span>JavaScript</span> <span>(</span><span>javascript</span><span>)</span></small>
```

Wonderful! We now have an accessible validation error message. Below you can see the error message visually displayed:

The validation error message is shown when the checkbox group is in an “invalid” state.

If using a screen reader, in this example, VoiceOver with Safari on macOS, the validation feedback is included with the `legend`. Also, notice the “required” feedback provided by the `aria-required` attribute on the `fieldset`:

![A screenshot of VoiceOver in Safari on macOS showing the legend of the checkbox group read along with validation feedback: "Interests, Select at least one interest, required, group".](https://cloudfour.com/wp-content/uploads/2023/08/Screen-Shot-2023-08-08-at-2.55.37-PM-1024x395.png)

When using a screen reader, the validation feedback is included when the `legend` is read.  
Pictured is VoiceOver in Safari on macOS.

[Permalink to Adding a group validation state icon and `aria-invalid` value](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-3-validating-a-checkbox-group/#adding-a-group-validation-state-icon-and-aria-invalid-value)

## Adding a group validation state icon and `aria-invalid` value

In Part 2, [each individual input had its own “valid”/”invalid” state icon and `aria-invalid` attribute](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-2-layering-in-javascript/#using-the-constraint-validation-api-to-validate-and-update-the-ui-state). We need to move those out onto the `fieldset` for a checkbox group.

Need a refresher on `aria-invalid`? See “[What does `aria-invalid` do?](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-2-layering-in-javascript/#what-does-aria-invalid-do)” in my previous article.

Let’s add a `js-*` CSS class to the `fieldset` so we can reference it in our JavaScript code:

```
<span><code id="code-lang-xml"><span><span><span>&lt;<span>fieldset</span> </span>
</span></span><span><span><span>  <span>aria-required</span>=<span>"true"</span> </span>
</span></span><mark><span><span>  <span>class</span>=<span>"js-checkbox-fieldset"</span></span>
</span></mark><span><span><span>&gt;</span>
</span></span></code></span><small id="shcb-language-11"><span>Code language:</span> <span>HTML, XML</span> <span>(</span><span>xml</span><span>)</span></small>
```

Then, in the `validateInterestsCheckboxGroup` function, we can add the following logic:

-   Get the `fieldset` element via the `js-*` CSS class
-   Depending on the `isValid` boolean, update:
    -   The `is-valid`/`is-invalid` state classes to toggle a single “valid”/”invalid” group icon
    -   The `aria-invalid` attribute

```
<span><code id="code-lang-javascript"><span><span><span>const</span> validateInterestsCheckboxGroup = <span>(<span>formEl</span>) =&gt;</span> {
</span></span><span><span>  <span>// Existing code from above…</span>
</span></span><span><span>
</span></span><span><span>  <span>// Get the fieldset element for the "interests" checkbox group.</span>
</span></span><mark><span>  <span>const</span> checkboxFieldsetEl = <span>document</span>.querySelector(<span>'.js-checkbox-fieldset'</span>);
</span></mark><span><span>
</span></span><span><span>  <span>// Need to place the validation state classes higher up to show</span>
</span></span><span><span>  <span>// a validation state icon (one icon for the group of checkboxes).</span>
</span></span><mark><span>  checkboxFieldsetEl.classList.toggle(<span>'is-valid'</span>, isValid);
</span></mark><mark><span>  checkboxFieldsetEl.classList.toggle(<span>'is-invalid'</span>, !isValid);
</span></mark><span><span>  <span>// Also update aria-invalid on the fieldset (convert to a string)</span>
</span></span><mark><span>  checkboxFieldsetEl.setAttribute(<span>'aria-invalid'</span>, <span>String</span>(!isValid));
</span></mark><span><span>
</span></span><span><span>  <span>// Return the validation state.</span>
</span></span><span><span>  <span>return</span> isValid;
</span></span><span><span>}
</span></span></code></span><small id="shcb-language-12"><span>Code language:</span> <span>JavaScript</span> <span>(</span><span>javascript</span><span>)</span></small>
```

Sweet! We can see a single group validation state icon in action below:

Checking at least one checkbox from the group shows the “valid” icon for the fieldset group. Unchecking all checkboxes shows the “invalid” icon for the group.

When using VoiceOver with Safari on macOS, the `aria-invalid` attribute adds “invalid data” to the validation feedback for the group:

![A screenshot of VoiceOver with Safari on macOS showing the "invalid" checkbox group state with VoiceOver reading "Interests, Select at least one interest., required, invalid data, group"](https://cloudfour.com/wp-content/uploads/2023/08/Screen-Shot-2023-08-10-at-2.55.04-PM-1024x612.png)

With the checkbox group in an “invalid” state, VoiceOver will add “invalid data” when the `aria-invalid="true"` is added to the `fieldset`.

[Permalink to Hooking into the existing form submit handler](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-3-validating-a-checkbox-group/#hooking-into-the-existing-form-submit-handler)

## Hooking into the existing form submit handler

In the previous article, [we set up the logic for the form `submit` event](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-2-layering-in-javascript/#handling-the-form-submit-event). Adding the checkbox group validation into the existing submit flow will be relatively straightforward.

Just a moment ago, in the `validateInterestsCheckboxGroup` function, we added [logic that stores and returns the validation state via the `isValid` boolean](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-3-validating-a-checkbox-group/#adding-the-validation-logic):

```
<span><code id="code-lang-javascript"><span><span><span>const</span> validateInterestsCheckboxGroup = <span>(<span>formEl</span>) =&gt;</span> {
</span></span><span><span>  <span>// Existing code from above…</span>
</span></span><span><span>
</span></span><span><span>  <span>// Return the validation state.</span>
</span></span><mark><span>  <span>return</span> isValid;
</span></mark><span><span>}
</span></span></code></span><small id="shcb-language-13"><span>Code language:</span> <span>JavaScript</span> <span>(</span><span>javascript</span><span>)</span></small>
```

We can use the returned boolean value to include the checkbox group validation within the existing `onSubmit` flow. We can add the following logic to that flow:

-   Call the `validateInterestsCheckboxGroup` function and store the returned boolean value
-   Include the returned boolean value in the “Is the form valid” check

```
<span><code id="code-lang-javascript"><span><span><span>const</span> onSubmit = <span>(<span>event</span>) =&gt;</span> {
</span></span><span><span>  <span>// Existing onSubmit code from Part 2…</span>
</span></span><span><span>
</span></span><span><span>  <span>// Fields that cannot be validated with the Constraint Validation API need</span>
</span></span><span><span>  <span>// to be validated manually. This includes the "interests" checkbox group.</span>
</span></span><mark><span>  <span>const</span> isInterestsGroupValid = validateInterestsCheckboxGroup(formEl);
</span></mark><span><span>  <span>// Prevent form submission if any of the validation checks fail.</span>
</span></span><mark><span>  <span>if</span> (!isFormValid || !isInterestsGroupValid) {
</span></mark><span><span>    event.preventDefault();
</span></span><span><span>  }
</span></span><span><span>};
</span></span></code></span><small id="shcb-language-14"><span>Code language:</span> <span>JavaScript</span> <span>(</span><span>javascript</span><span>)</span></small>
```

And that’s it! Now, the checkbox group will also be validated when the form is submitted:

When the form is submitted, the checkbox group is validated.

[Permalink to Include the checkbox group in the “first invalid input” focus](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-3-validating-a-checkbox-group/#include-the-checkbox-group-in-the-first-invalid-input-focus)

## Include the checkbox group in the “first invalid input” focus

Some of the work in the form submit logic introduced in Part 2 was to [set focus on the first invalid input when the form is submitted](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-2-layering-in-javascript/#handling-the-form-submit-event). We’ll want to ensure the checkbox group is included in this query.

To do so, we’ll need to make another update to the existing `onSubmit` handler as follows:

-   Add a selector for the `input` in a `fieldset` that has the `is-invalid` state class (e.g., `'fieldset.is-invalid input'`)

```
<span><code id="code-lang-javascript"><span><span><span>const</span> onSubmit = <span>(<span>event</span>) =&gt;</span> {
</span></span><span><span>  <span>// Existing onSubmit code from Part 2…</span>
</span></span><span><span>
</span></span><span><span>  <span>// Set the focus to the first invalid input.</span>
</span></span><span><span>  <span>const</span> firstInvalidInputEl = formEl.querySelector(
</span></span><mark><span>    <span>'input:invalid, fieldset.is-invalid input'</span>
</span></mark><span><span>  );
</span></span><span><span>  firstInvalidInputEl?.focus();
</span></span><span><span>};
</span></span></code></span><small id="shcb-language-15"><span>Code language:</span> <span>JavaScript</span> <span>(</span><span>javascript</span><span>)</span></small>
```

**Note:** The order of operations matters here. The `validateInterestsCheckboxGroup` function must be called before attempting to query for `fieldset.is-invalid input`. Otherwise, the `fieldset` won’t have the `is-invalid` class to query by.

It’s almost like magic! Below, you can see the group’s first checkbox input receiving focus when no checkbox is selected and the form is submitted:

The first checkbox in the group receives focus when the form is submitted if the group is the first invalid input.

[Permalink to Selectively validate the checkbox group on page load](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-3-validating-a-checkbox-group/#selectively-validate-the-checkbox-group-on-page-load)

## Selectively validate the checkbox group on page load

We are near the finish line! One last thing to do. Currently, the checkbox group validation will only happen when a checkbox input’s `change`, `blur`, or form `submit` events fire. There is one more case we should handle: What if a checkbox is checked and the browser reloads the page?

Ideally, if the page loads with at least one selection made, it should show the “valid” UI state. At the moment, nothing happens, and the checkbox group ends up in this unresolved state:

![The "interests" checkbox group with "music" and "art" selected but the "valid" UI state is not rendered.](https://cloudfour.com/wp-content/uploads/2023/08/Screen-Shot-2023-08-31-at-5.19.53-AM-1024x814.png)

The “valid” checkbox group UI state should render when at least one checkbox is checked on page load.

We can resolve this by adding the following logic to the existing `init` function from Part 2:

-   Query for all “interests” inputs (the checkboxes) that have a `:checked` state
-   If any are checked, run the `validateInterestsCheckboxGroup` function so the “valid” UI state can render

```
<span><code id="code-lang-javascript"><span><span><span>/**</span>
</span></span><span><span><span> * Initialize validation setup</span>
</span></span><span><span><span> */</span>
</span></span><span><span><span>const</span> init = <span><span>()</span> =&gt;</span> {
</span></span><span><span>  <span>// Existing code from Part 2 here…</span>
</span></span><span><span>
</span></span><span><span>  <span>// On page load, if a checkbox is checked, update the group's UI state</span>
</span></span><mark><span>  <span>const</span> isInterestsGroupChecked =
</span></mark><mark><span>    <span>document</span>.querySelectorAll(<span>'input[name="interests"]:checked'</span>).length &gt; <span>0</span>;
</span></mark><mark><span>  <span>if</span> (isInterestsGroupChecked) {
</span></mark><mark><span>    validateInterestsCheckboxGroup(formEl);
</span></mark><mark><span>  }
</span></mark><span><span>};
</span></span><span><span>
</span></span></code></span><small id="shcb-language-16"><span>Code language:</span> <span>JavaScript</span> <span>(</span><span>javascript</span><span>)</span></small>
```

Easy peasy! Now, when the page loads with at least one checkbox selected, we see the “valid” UI state as expected:

![The "interests" checkbox group with "music" and "art" selected with the "valid" UI state rendered.](https://cloudfour.com/wp-content/uploads/2023/08/Screen-Shot-2023-08-31-at-5.21.33-AM-1024x797.png)

The checkbox group “valid” UI state now renders on page load if at least one checkbox is selected.

[Permalink to Why not validate the checkbox group on every page load?](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-3-validating-a-checkbox-group/#why-not-validate-the-checkbox-group-on-every-page-load)

### Why not validate the checkbox group on every page load?

We don’t want to run the `validateInterestsCheckboxGroup` function every time the validation code is initialized because if no checkboxes are checked, then the “invalid” UI state will render. This pattern, called [premature validation](https://baymard.com/blog/inline-form-validation#pitfall-1-premature-inline-validation), is not helpful and leads to a frustrating user experience.

[Permalink to Future improvement opportunities](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-3-validating-a-checkbox-group/#future-improvement-opportunities)

## Future improvement opportunities

Because we can always learn more and keep growing, I wanted to note a few opportunities to improve the user experience.

-   **Localize the validation error message**: Currently, the validation error message is hard-coded in English in JavaScript. Ideally, the message can be localized into different languages.
-   **Remove or minimize the layout shift when validation error messages are displayed**: When the error messages are displayed, there is a visual layout shift. This issue is not specific to the checkbox group, but it becomes more prominent (and annoying) as more fieldsets/inputs are added to the form.

[Permalink to Wrapping up](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-3-validating-a-checkbox-group/#wrapping-up)

## Wrapping up

That was fun! I’ll admit that the perfectionist in me almost gave up on finding an accessible validation solution for a checkbox group, but I’m glad I pushed through. Finding a solution feels good, even if not ideal, especially knowing the native HTML validation features leave us short.

Stick around for the following article, [Part 4](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-4-custom-validation-messages/), where we explore using the Constraint Validation API’s [`ValidityState` interface](https://developer.mozilla.org/en-US/docs/Web/API/ValidityState) to help render custom validation error messages.

Until next time!

A special thank you to [Juliette Alexandria](https://www.linkedin.com/in/juliette-alexandria-8946a91b0/), [Adrian Roselli](https://adrianroselli.com/), and Joe Schunk, who provided me with feedback, resources, and confirmation for creating a more accessible checkbox group validation experience via the [web-a11y.slack.com](https://web-a11y.slack.com/) Slack community. 🙌🏽

[Permalink to More resources](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-3-validating-a-checkbox-group/#more-resources)

## More resources

-   [MDN Web Docs: Handling multiple checkboxes](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/checkbox#handling_multiple_checkboxes)
-   [MDN Web Docs: Validating forms without a built-in API](https://developer.mozilla.org/en-US/docs/Learn/Forms/Form_validation#validating_forms_without_a_built-in_api)
-   [MDN Web Docs: Checkbox input type validation](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/checkbox#validation)
-   [Support for Marking Radio Buttons Required, Invalid](https://adrianroselli.com/2022/02/support-for-marking-radio-buttons-required-invalid.html) by Adrian Roselli
-   “[Use `<fieldset aria-requried="true">`](https://twitter.com/aardrian/status/1225185061668098048)” and “[Use `<fieldset aria-invalid="true">`](https://twitter.com/aardrian/status/1253053177395625984)” tweets from Adrian Roselli
-   [Axe Rules: Checkbox inputs with the same name attribute value must be part of a group](https://dequeuniversity.com/rules/axe/3.5/checkboxgroup)
-   [HTML.form.guide: HTML Form Checkbox with required validation](https://html.form.guide/checkbox/html-form-checkbox-required/)

[Permalink to Missed an article in the series?](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-3-validating-a-checkbox-group/#missed-an-article-in-the-series)

## Missed an article in the series?

I’ve got you! Listed below are all of the articles from the series:

-   [Part 1: HTML and CSS](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-1-html-and-css/)
-   [Part 2: Layering in JavaScript](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-2-layering-in-javascript/)
-   [Part 3: Validating a checkbox group](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-3-validating-a-checkbox-group/)
-   [Part 4: Custom validation messages](https://cloudfour.com/thinks/progressively-enhanced-form-validation-part-4-custom-validation-messages/)
