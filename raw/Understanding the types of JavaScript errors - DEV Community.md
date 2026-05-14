---
id: 17709bf3-6907-46c0-8875-64c80c69f4eb
tags:
  - JavaScript
  - save-js
---

# Understanding the types of JavaScript errors - DEV Community
#Omnivore

[Read on Omnivore](https://omnivore.app/me/understanding-the-types-of-java-script-errors-dev-community-18d0e8089a9)
[Read Original](https://dev.to/sharifmrahat/understanding-the-types-of-javascript-errors-3d8)

JavaScript, the language that powers the interactive and dynamic aspects of the web, has become an integral part of modern web development. While coding in JavaScript, developers often encounter errors that can be challenging to debug. 

Errors are like friendly notes from your computer, telling you where your code might need a little help. Think of them as clues that point to specific issues. These errors come in different types, each with its own way of saying, "Hey, something's not quite right here." Understanding these types is like having a special guide to fix problems and make sure your code works smoothly. In this blog post, we will explore the types of JavaScript errors, and discuss strategies to effectively handle and debug them.

### [ ](#1-syntax-error) 1\. Syntax Error:

* Syntax errors occur when there is a mistake in the structure of your code.
* These errors are detected by the JavaScript engine during the parsing phase.
* Common causes include missing parentheses, mismatched braces, or typos in variable/function names.
* The error message usually points to the line where the syntax violation occurred.

```sql
// Example with missing closing parenthesis
console.log('Hello World';

```

```sas
console.log('Hello World';
            ^^^^^^^^^^^^^
SyntaxError: missing ) after argument list

```

### [ ](#2-reference-error) 2\. Reference Error:

* Reference errors occur when trying to reference a variable or function that hasn't been declared.
* It often happens when using a variable before it's defined or trying to access properties on undefined or null values.
* Properly declaring variables and ensuring they are in scope helps prevent reference errors.

```1c
// Example referencing an undeclared variable
console.log(undefinedVariable);

```

```applescript
console.log(undefinedVariable);
            ^^^^^^^^^^^^^^^^^
ReferenceError: undefinedVariable is not defined

```

### [ ](#3-type-error) 3\. Type Error:

* Type errors occur when an operation is performed on an inappropriate data type.
* Examples include attempting to call a method on a non-function or accessing a property on a non-object.
* Type errors are often resolved by validating the types of variables before performing operations.

```typescript
// Example calling a number as a function
let number = 42;
number();

```

```asciidoc
number();
^^^^^^
TypeError: number is not a function

```

### [ ](#4-range-error) 4\. Range Error:

* Range errors occur when a numeric value is not within an allowed range. Typically associated with methods or operations that expect a specific numeric range.
* Range errors are often resolved by Validating input values before using them in operations that have specific numeric requirements.
* Use conditional statements to check whether a value falls within the acceptable range before performing an operation.

```smali
// Example creating an array with a negative length
let arr = new Array(-1);

```

```smali
let arr = new Array(-1);
          ^^^^^^^^^^^^^
RangeError: Invalid array length

```

### [ ](#5-uri-error) 5\. URI Error

* URI errors occur when encodeURI() or decodeURI() are passed invalid parameters.
* These errors are related to encoding and decoding Uniform Resource Identifiers (URIs), such as URLs.
* Ensure that input strings provided to encodeURI() or decodeURI() adhere to URI standards. Validate user-generated input to prevent the passing of malformed URIs.

```javascript
// Example attempting to decode an invalid URI
decodeURI('%');

```

```javascript
decodeURI('%');
           ^
URIError: URI malformed

```

### [ ](#6-internal-error) 6\. Internal Error

* These errors might be caused by limitations or bugs in the JavaScript engine, memory issues, or other unforeseen internal problems.
* For example, this error occurs most often when there is  
   * too many switch cases  
   * too many parentheses in regular expression  
   * array initializer too large  
   * too much recursion.  
   * too much data and the stack exceeds its critical size.
* In the mentioned scenarios, the JavaScript engine becomes overwhelmed, leading to the occurrence of an Internal Error.

```angelscript
switch(condition) {
    case 1:
    ...
    break
    case 2:
    ...
    break
    case 3:
    ...
    break
    case 4:
    ...
    break
    case 5:
    ...
    break
    case 6:
    ...
    break
    case 7:
    ...
    break
    ... up to 500 cases
    }

```

### [ ](#7-evaluation-error-deprecated) 7\. Evaluation Error (Deprecated):

* EvalError is deprecated and not commonly used in modern JavaScript. It was intended to represent errors that occur with the eval() function.
* Current JavaScript engines and EcmaScript specifications do not throw this error.
* However, it is still available for backward compatibility. The error is called when the eval() backward

```maxima
// Example of eval error
try{
  throw new EvalError("'Throws an error'")
}catch(error){
  console.log(error.name, error.message)
}

```

```javascript
EvalError 'Throws an error'

```

To wrap it up, dealing with JavaScript errors is like having a helpful friend guide you in your coding adventure. Instead of seeing errors as big problems, think of them as tips showing you how to make your code stronger. When you learn about and fix these issues, you're not just making things right; you're getting really good at making sure your code talks nicely to the computer. Keep enjoying your coding journey!

---

### [ ](#important-links) Important Links:

1. [List of JavaScript errors - Mozilla MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Errors)
2. [JavaScript errors - W3 Schools](https://www.w3schools.com/jsref/jsref%5Fobj%5Ferror.asp)
3. [Type vs Ref. error - freeCodeCamp](https://www.freecodecamp.org/news/type-error-vs-reference-error-javascript/)
4. [JS errors & handling - GeeksForGeeks](https://www.geeksforgeeks.org/javascript-error-and-exceptional-handling-with-examples/?ref=header%5Fsearch)