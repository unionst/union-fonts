//
//  Font+Weight.swift
//  union-fonts
//
//  Created by Ben Sage on 6/11/25.
//

import SwiftUI

private extension Int {
    var asFontWeight: Font.Weight {
        switch self {
        case 100: .thin
        case 200: .ultraLight
        case 300: .light
        case 400: .regular
        case 500: .medium
        case 600: .semibold
        case 700: .bold
        case 800: .heavy
        case 900: .black
        default: fatalError("Unsupported weight \(self)")
        }
    }
}

extension Font {
    public func weight(_ value: Int) -> Font {
        weight(value.asFontWeight)
    }
}

extension View {
    @available(iOS 16.0, macOS 13.0, *)
    public func fontWeight(_ value: Int) -> some View {
        fontWeight(value.asFontWeight)
    }
}
