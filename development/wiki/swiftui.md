# SwiftUI (Development Reference)

This is a cross-reference entry. The SwiftUI knowledge base is maintained in the dedicated `swiftui/` topic folder.

## Quick Links

- [swiftui/wiki/README](../../swiftui/wiki/README.md) — SwiftUI wiki home
- [swiftui/wiki/viewmodifier](../../swiftui/wiki/viewmodifier.md) — The ViewModifier pattern: reusable, composable UI modifier bundles

## Summary

SwiftUI's `ViewModifier` protocol allows you to group modifier chains into named, reusable bundles — the essential pattern for maintainable iOS 26 / Liquid Glass UI development.

```swift
struct LiquidCardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(20)
            .background(.ultraThinMaterial)
            .cornerRadius(18)
    }
}

extension View {
    func liquidCard() -> some View {
        modifier(LiquidCardModifier())
    }
}
```

## Related
- [swiftui/wiki/viewmodifier](../../swiftui/wiki/viewmodifier.md) — Full article
- [README](README.md) — Development wiki home
