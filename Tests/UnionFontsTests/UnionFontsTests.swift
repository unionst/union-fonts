import XCTest
import SwiftUI
@testable import UnionFonts

final class UnionFontsTests: XCTestCase {
    
    func testSystemFontWithoutOpenTypeFeatures() {
        let font = Font.system(
            size: 16,
            weight: .bold,
            design: .rounded,
            openTypeFeatures: [:]
        )
        
        XCTAssertNotNil(font)
    }
    
    func testSystemFontWithOpenTypeFeatures() {
        let font = Font.system(
            size: 16,
            weight: .bold,
            design: .rounded,
            openTypeFeatures: ["cv09": 1, "cv10": 1]
        )
        
        XCTAssertNotNil(font)
    }
    
    func testSystemFontWithBooleanFeatures() {
        let font = Font.system(
            size: 16,
            weight: .medium,
            design: .serif,
            features: [
                OpenTypeFeatures.standardLigatures: true,
                OpenTypeFeatures.slashedZero: false
            ]
        )
        
        XCTAssertNotNil(font)
    }
    
    func testAllFontWeights() {
        let weights: [Font.Weight] = [
            .ultraLight, .thin, .light, .regular,
            .medium, .semibold, .bold, .heavy, .black
        ]
        
        for weight in weights {
            let font = Font.system(
                size: 14,
                weight: weight,
                openTypeFeatures: ["liga": 1]
            )
            XCTAssertNotNil(font)
        }
    }
    
    func testAllFontDesigns() {
        let designs: [Font.Design] = [.default, .serif, .rounded, .monospaced]
        
        for design in designs {
            let font = Font.system(
                size: 14,
                design: design,
                openTypeFeatures: ["kern": 1]
            )
            XCTAssertNotNil(font)
        }
    }
    
    func testOpenTypeFeaturesHelpers() {
        XCTAssertEqual(OpenTypeFeatures.characterVariant(1), "cv01")
        XCTAssertEqual(OpenTypeFeatures.characterVariant(9), "cv09")
        XCTAssertEqual(OpenTypeFeatures.characterVariant(99), "cv99")
        
        XCTAssertEqual(OpenTypeFeatures.stylisticSet(1), "ss01")
        XCTAssertEqual(OpenTypeFeatures.stylisticSet(15), "ss15")
        XCTAssertEqual(OpenTypeFeatures.stylisticSet(20), "ss20")
        
        XCTAssertEqual(OpenTypeFeatures.standardLigatures, "liga")
        XCTAssertEqual(OpenTypeFeatures.discretionaryLigatures, "dlig")
        XCTAssertEqual(OpenTypeFeatures.kerning, "kern")
        XCTAssertEqual(OpenTypeFeatures.slashedZero, "zero")
    }
    
    func testCharacterVariantBounds() {
        XCTAssertEqual(OpenTypeFeatures.characterVariant(1), "cv01")
        XCTAssertEqual(OpenTypeFeatures.characterVariant(99), "cv99")
    }
    
    func testStylisticSetBounds() {
        XCTAssertEqual(OpenTypeFeatures.stylisticSet(1), "ss01")
        XCTAssertEqual(OpenTypeFeatures.stylisticSet(20), "ss20")
    }
    
    func testExistingWeightExtension() {
        let font = Font.system(size: 16).weight(700)
        XCTAssertNotNil(font)
    }
}
