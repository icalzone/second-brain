# C# and Razor Syntax

A quick reference for C# Razor syntax in ASP.NET MVC and .NET views, plus links to broader .NET patterns.

## Razor Syntax Quick Reference

Razor allows you to mix C# server-side code with HTML using the `@` symbol.

| Syntax | Example |
|---|---|
| **Code block** | `@{ int x = 123; string y = "text"; }` |
| **Inline expression (HTML encoded)** | `<span>@model.Message</span>` |
| **Inline expression (unencoded)** | `<span>@Html.Raw(model.Message)</span>` |
| **Loop with markup** | `@foreach(var item in items) { <span>@item.Prop</span> }` |
| **Mixing code and plain text** | `@if (foo) { <text>Plain Text</text> }` |
| **Using block** | `@using (Html.BeginForm()) { <input type="text"> }` |
| **Plain text alternate** | `@if (foo) { @:Plain Text is @bar }` |
| **Email address (no ambiguity)** | `somebody@@somewhere.com` |
| **Explicit expression** | `@(item.Id + "-" + item.Name)` |
| **Comment** | `@* This is a Razor comment *@` |
| **Conditional** | `@if (condition) { ... } else { ... }` |
| **Switch** | `@switch(x) { case 1: break; }` |
| **Try/Catch** | `@try { ... } catch (Exception ex) { ... }` |
| **Using statement** | `@using MyNamespace` |
| **Inherit from** | `@inherits MyBaseClass` |
| **Implement interface** | `@implements IDisposable` |
| **Model declaration** | `@model MyViewModel` |
| **Generic model** | `@model IEnumerable<MyType>` |
| **Helper** | `@helper MyHelper(string arg) { ... }` |
| **Functions block** | `@functions { public string MyMethod() { ... } }` |
| **Section** | `@section Scripts { <script>...</script> }` |

## Key Principles

- `@` is the magic character — it switches from HTML to C# context
- `@@` renders a literal `@` (useful for email addresses)
- `@Html.Raw()` outputs unencoded HTML — use with caution; never with user input (XSS risk)
- `<text>` tag is used to output plain text when inside a code block without a wrapping HTML tag
- `@:` is a shortcut for outputting a single line of plain text inside a code block

## C# Patterns in Action

See also `development/raw/patterns-in-action.md` for design patterns including:
- **Builder Pattern** — `FrogBuilder` example (also in [[javascript]])
- Additional design pattern examples

## Related
- [[optimizely-cms]] — Razor is used extensively in Optimizely/Episerver view development
- [[javascript]] — Front-end complement to Razor back-end views
- [[INDEX]] — Development wiki home

## Sources
- `development/raw/Csharp-Razor-Syntax-Quick-Reference.md` — from haacked.com (2011, still relevant)
- `development/raw/patterns-in-action.md`
