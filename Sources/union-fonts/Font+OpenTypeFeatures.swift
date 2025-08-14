//
//  Font+OpenTypeFeatures.swift
//  union-fonts
//
//  Created by Ben Sage on 8/14/25.
//

import SwiftUI
import CoreText

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

extension Font {
    public static func system(
        size: CGFloat,
        weight: Font.Weight = .regular,
        design: Font.Design = .default,
        openTypeFeatures: [String: Int]
    ) -> Font {
        guard !openTypeFeatures.isEmpty else {
            return .system(size: size, weight: weight, design: design)
        }
        
        #if canImport(UIKit)
        return createiOSFont(size: size, weight: weight, design: design, openTypeFeatures: openTypeFeatures)
        #elseif canImport(AppKit)
        return createmacOSFont(size: size, weight: weight, design: design, openTypeFeatures: openTypeFeatures)
        #else
        return .system(size: size, weight: weight, design: design)
        #endif
    }
}

#if canImport(UIKit)
private func createiOSFont(
    size: CGFloat,
    weight: Font.Weight,
    design: Font.Design,
    openTypeFeatures: [String: Int]
) -> Font {
    let uiWeight = weight.uiWeight
    let uiDesign = design.uiDesign
    
    var baseFont = UIFont.systemFont(ofSize: size, weight: uiWeight)
    
    if let design = uiDesign {
        let descriptor = baseFont.fontDescriptor.withDesign(design)
        if let designedDescriptor = descriptor {
            baseFont = UIFont(descriptor: designedDescriptor, size: size)
        }
    }
    
    let featureSettings = openTypeFeatures.map { (tag, value) in
        [
            kCTFontOpenTypeFeatureTag: tag,
            kCTFontOpenTypeFeatureValue: value
        ] as [CFString: Any]
    }
    
    let attributes: [UIFontDescriptor.AttributeName: Any] = [
        .featureSettings: featureSettings
    ]
    
    let descriptor = baseFont.fontDescriptor.addingAttributes(attributes)
    let finalFont = UIFont(descriptor: descriptor, size: size)
    
    return Font(finalFont)
}

private extension Font.Weight {
    var uiWeight: UIFont.Weight {
        switch self {
        case .ultraLight: return .ultraLight
        case .thin: return .thin
        case .light: return .light
        case .regular: return .regular
        case .medium: return .medium
        case .semibold: return .semibold
        case .bold: return .bold
        case .heavy: return .heavy
        case .black: return .black
        default: return .regular
        }
    }
}

private extension Font.Design {
    var uiDesign: UIFontDescriptor.SystemDesign? {
        switch self {
        case .default: return nil
        case .serif: return .serif
        case .rounded: return .rounded
        case .monospaced: return nil
        default: return nil
        }
    }
}
#endif

#if canImport(AppKit)
private func createmacOSFont(
    size: CGFloat,
    weight: Font.Weight,
    design: Font.Design,
    openTypeFeatures: [String: Int]
) -> Font {
    let nsWeight = weight.nsWeight
    let nsDesign = design.nsDesign
    
    var baseFont = NSFont.systemFont(ofSize: size, weight: nsWeight)
    
    if let design = nsDesign {
        let descriptor = baseFont.fontDescriptor.withDesign(design)
        if let designedDescriptor = descriptor {
            baseFont = NSFont(descriptor: designedDescriptor, size: size) ?? baseFont
        }
    }
    
    let featureSettings = openTypeFeatures.map { (tag, value) in
        [
            kCTFontOpenTypeFeatureTag: tag,
            kCTFontOpenTypeFeatureValue: value
        ] as [CFString: Any]
    }
    
    let attributes: [NSFontDescriptor.AttributeName: Any] = [
        .featureSettings: featureSettings
    ]
    
    let descriptor = baseFont.fontDescriptor.addingAttributes(attributes)
    let finalFont = NSFont(descriptor: descriptor, size: size) ?? baseFont
    
    return Font(finalFont)
}

private extension Font.Weight {
    var nsWeight: NSFont.Weight {
        switch self {
        case .ultraLight: return .ultraLight
        case .thin: return .thin
        case .light: return .light
        case .regular: return .regular
        case .medium: return .medium
        case .semibold: return .semibold
        case .bold: return .bold
        case .heavy: return .heavy
        case .black: return .black
        default: return .regular
        }
    }
}

private extension Font.Design {
    var nsDesign: NSFontDescriptor.SystemDesign? {
        switch self {
        case .default: return nil
        case .serif: return .serif
        case .rounded: return .rounded
        case .monospaced: return nil
        default: return nil
        }
    }
}
#endif

public struct OpenTypeFeatures {
    public static let standardLigatures = "liga"
    public static let discretionaryLigatures = "dlig"
    public static let kerning = "kern"
    public static let slashedZero = "zero"
    
    public static func characterVariant(_ number: Int) -> String {
        guard number >= 1 && number <= 99 else {
            fatalError("Character variant must be between 1 and 99")
        }
        return String(format: "cv%02d", number)
    }
    
    public static func stylisticSet(_ number: Int) -> String {
        guard number >= 1 && number <= 20 else {
            fatalError("Stylistic set must be between 1 and 20")
        }
        return String(format: "ss%02d", number)
    }
}

public extension Font {
    static func system(
        size: CGFloat,
        weight: Font.Weight = .regular,
        design: Font.Design = .default,
        features: [String: Bool]
    ) -> Font {
        let openTypeFeatures = features.mapValues { $0 ? 1 : 0 }
        return system(size: size, weight: weight, design: design, openTypeFeatures: openTypeFeatures)
    }
}
