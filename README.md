# UnionFonts

A Swift Package Manager library that extends SwiftUI's Font API to support OpenType font features, enabling advanced typography in SwiftUI applications.

## Features

- 🎨 **OpenType Feature Support** - Access advanced typography features like character variants, stylistic sets, and ligatures
- 🔧 **SwiftUI Integration** - Seamless extension of SwiftUI's Font API
- 💰 **Financial App Ready** - Perfect for currency displays with improved dollar sign rendering
- 🏷️ **Type Safe** - Compile-time safety with helper functions for common features
- 📱 **Cross Platform** - Supports iOS 14+ and macOS 11+

## Installation

### Swift Package Manager

Add UnionFonts to your project through Xcode:

1. File → Add Package Dependencies...
2. Enter the repository URL
3. Choose version and add to your target

Or add it to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/unionst/union-fonts", from: "1.0.0")
]
```

## Quick Start

```swift
import SwiftUI
import UnionFonts

struct ContentView: View {
    var body: some View {
        VStack {
            // Regular SwiftUI font
            Text("$123.45")
                .font(.system(size: 24, weight: .bold, design: .rounded))
            
            // Enhanced with OpenType features for better dollar sign
            Text("$123.45")
                .font(.system(
                    size: 24,
                    weight: .bold,
                    design: .rounded,
                    openTypeFeatures: ["cv09": 1, "cv10": 1]
                )
                )
        }
    }
}
```

## OpenType Features

### Character Variants

Character variants provide alternative glyphs for specific characters:

```swift
Text("$199.99")
    .font(.system(
        size: 20,
        openTypeFeatures: [
            OpenTypeFeatures.characterVariant(9): 1,  // cv09
            OpenTypeFeatures.characterVariant(10): 1  // cv10
        ]
    )
    )
```

### Stylistic Sets

Stylistic sets apply coordinated design changes:

```swift
Text("Typography")
    .font(.system(
        size: 18,
        openTypeFeatures: [
            OpenTypeFeatures.stylisticSet(1): 1  // ss01
        ]
    )
    )
```

### Ligatures and Kerning

Control text rendering features:

```swift
Text("Office")
    .font(.system(
        size: 16,
        features: [
            OpenTypeFeatures.standardLigatures: true,
            OpenTypeFeatures.discretionaryLigatures: false,
            OpenTypeFeatures.kerning: true
        ]
    )
    )
```

### Boolean Feature Syntax

For simple on/off features, use the boolean syntax:

```swift
Text("Code 0123")
    .font(.system(
        size: 14,
        design: .monospaced,
        features: [
            OpenTypeFeatures.slashedZero: true,
            OpenTypeFeatures.standardLigatures: false
        ]
    )
    )
```

## Advanced Usage

### Custom Font Style System

Create reusable font styles with OpenType features:

```swift
struct CustomFontStyle {
    let size: CGFloat
    let weight: Font.Weight
    let design: Font.Design
    let openTypeFeatures: [String: Int]
    
    var swiftUI: Font {
        if !openTypeFeatures.isEmpty {
            return Font.system(
                size: size,
                weight: weight,
                design: design,
                openTypeFeatures: openTypeFeatures
            )
        } else {
            return Font.system(size: size, weight: weight, design: design)
        }
    }
}

// Usage
let currencyStyle = CustomFontStyle(
    size: 24,
    weight: .semibold,
    design: .rounded,
    openTypeFeatures: ["cv09": 1, "cv10": 1]
)

Text("$4,299.00").font(currencyStyle.swiftUI)
```

### Theme Integration

Integrate with your app's design system:

```swift
extension Font {
    static var currencyDisplay: Font {
        .system(
            size: 28,
            weight: .bold,
            design: .rounded,
            openTypeFeatures: ["cv09": 1, "cv10": 1]
        )
    }
    
    static var codeDisplay: Font {
        .system(
            size: 14,
            design: .monospaced,
            features: [
                OpenTypeFeatures.slashedZero: true,
                OpenTypeFeatures.standardLigatures: false
            ]
        )
    }
}
```

## Common OpenType Features

| Feature | Tag | Description |
|---------|-----|-------------|
| Character Variants | `cv01`-`cv99` | Alternative character designs |
| Stylistic Sets | `ss01`-`ss20` | Coordinated style alternatives |
| Standard Ligatures | `liga` | Common letter combinations (fi, fl) |
| Discretionary Ligatures | `dlig` | Optional decorative ligatures |
| Kerning | `kern` | Letter spacing adjustments |
| Slashed Zero | `zero` | Zero with diagonal slash |

## Real-World Use Cases

### Financial Applications

Improve currency display with better dollar sign rendering:

```swift
Text("$4,299.99")
    .font(.system(
        size: 32,
        weight: .bold,
        design: .rounded,
        openTypeFeatures: ["cv09": 1, "cv10": 1]
    )
    )
```

This creates a smaller, less intrusive dollar sign that doesn't overpower the numbers.

### Code Editors

Enhance code readability:

```swift
Text("let value = 0123")
    .font(.system(
        size: 14,
        design: .monospaced,
        features: [
            OpenTypeFeatures.slashedZero: true,
            OpenTypeFeatures.standardLigatures: false
        ]
    )
    )
```

### Typography-Focused Apps

Access advanced typographic features:

```swift
Text("Beautiful Typography")
    .font(.system(
        size: 24,
        weight: .light,
        design: .serif,
        openTypeFeatures: [
            OpenTypeFeatures.stylisticSet(1): 1,
            OpenTypeFeatures.discretionaryLigatures: 1
        ]
    )
    )
```

## API Reference

### Font Extensions

```swift
extension Font {
    static func system(
        size: CGFloat,
        weight: Font.Weight = .regular,
        design: Font.Design = .default,
        openTypeFeatures: [String: Int]
    ) -> Font
    
    static func system(
        size: CGFloat,
        weight: Font.Weight = .regular,
        design: Font.Design = .default,
        features: [String: Bool]
    ) -> Font
}
```

### OpenTypeFeatures Helpers

```swift
public struct OpenTypeFeatures {
    static let standardLigatures: String
    static let discretionaryLigatures: String
    static let kerning: String
    static let slashedZero: String
    
    static func characterVariant(_ number: Int) -> String
    static func stylisticSet(_ number: Int) -> String
}
```

## Weight Extension

The package also includes a convenient integer-based weight extension:

```swift
Text("Bold Text")
    .font(.system(size: 16))
    .weight(700)  // Equivalent to .bold

// Or for views
Text("Medium Text")
    .fontWeight(500)  // Equivalent to .medium
```

## Compatibility

- **iOS**: 14.0+
- **macOS**: 11.0+
- **Swift**: 5.5+
- **Xcode**: 13.0+

## Performance

The implementation is optimized for performance:
- Efficient font descriptor caching
- No unnecessary object retention
- Main thread safe
- Minimal overhead for non-OpenType usage

## Contributing

Contributions are welcome! Please feel free to submit issues and pull requests.

## License

This project is available under the MIT license.
