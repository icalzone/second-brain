---
type: concept
domains: [work]
status: evolving
source-confidence: high
updated: 2026-05-14
---

# .NET & ASP.NET Patterns

Reference patterns for C#, Razor, ASP.NET Core, and related technologies.

## Razor Syntax Quick Reference

| Construct | Syntax |
|-----------|--------|
| Code block | `@{ int x = 123; string y = "hello"; }` |
| Expression (HTML encoded) | `<span>@model.Message</span>` |
| Expression (unencoded) | `@Html.Raw(model.Message)` |
| Markup in code | `@foreach(var item in items) { <span>@item.Prop</span> }` |
| Plain text in code block | `@if (foo) { <text>Plain text</text> }` |
| Inline plain text | `@:Plain text is @bar` |
| Using block | `@using (Html.BeginForm()) { <input type="text"> }` |
| Template literals | `@("<span>@item</span>")` |

→ Source: [Csharp-Razor-Syntax-Quick-Reference](/raw/Csharp-Razor-Syntax-Quick-Reference.md)

---

## ASP.NET Core Tag Helpers

### FontAwesome Inline SVG Tag Helper

**Problem:** FontAwesome's SVG+JS bundle is 400KB+ per icon set (~1.6MB for all four). Too heavy for small sites.

**Solution:** Inline the raw SVG icons directly in HTML using a custom ASP.NET Core tag helper.

**Setup:**
1. Copy raw SVG files from FontAwesome Pro (`advanced-options/raw-svg`) into your project under `Assets/FontAwesome`
2. Configure `.csproj` to copy SVGs to output:
   ```xml
   <ItemGroup>
     <Content Include="Assets\**\*.svg">
       <CopyToOutputDirectory>PreserveNewest</CopyToOutputDirectory>
     </Content>
   </ItemGroup>
   ```
3. Build a tag helper that reads the SVG file from disk and writes its contents inline into the HTML output
4. Add CSS to control icon sizing and alignment

**Trade-off:** Only the icons you actually use are loaded; zero JS bundle overhead. Requires server-side file reads.

→ Source: [Fontawesome tag helper](/raw/Fontawesome%20tag%20helper.md)

---

## SwiftUI (iOS)

### ViewModifier Pattern

Group repeated modifier chains into a reusable `ViewModifier` struct. One place to update design specs instead of hunting through multiple views.

```swift
// Define
struct LiquidCardModifier: ViewModifier {
    var isPressed: Bool = false

    func body(content: Content) -> some View {
        content
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .background(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(.ultraThinMaterial)
                    .shadow(color: .black.opacity(0.12), radius: 12, y: 6)
            )
            .scaleEffect(isPressed ? 0.97 : 1.0)
            .animation(.spring(response: 0.35, dampingFraction: 0.72), value: isPressed)
    }
}

// Expose via View extension (cleaner call site)
extension View {
    func liquidCard(isPressed: Bool = false) -> some View {
        modifier(LiquidCardModifier(isPressed: isPressed))
    }
}

// Use
MyCardView()
    .liquidCard(isPressed: buttonPressed)
```

**Use when:** the same 3+ modifier chain appears in 2+ places. Any design change is a single edit.

→ Source: [swiftui-viewmodifier-pattern-ios-apps](/raw/swiftui-viewmodifier-pattern-ios-apps.md)
