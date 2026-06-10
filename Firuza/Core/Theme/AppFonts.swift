import SwiftUI
import UIKit

enum AppFonts {
    
    static func largeTitle(
        weight: Font.Weight = .semibold) -> Font {
        .system(size: 32, weight: weight)
    }
    
    static func timeTitle(
        weight: Font.Weight = .bold) -> Font {
        .system(size: 33, weight: weight)
    }
    
    static func body1(
        weight: Font.Weight = .regular) -> Font {
        .system(size: 15, weight: weight)
    }
    
    static func body2(
        weight: Font.Weight = .regular) -> Font {
        .system(size: 14, weight: weight)
    }
    
    static func cardTitle(
        weight: Font.Weight = .semibold) -> Font {
        .system(size: 16, weight: weight)
    }
    
    static func cardTitle2(
        weight: Font.Weight = .regular) -> Font {
        .system(size: 14, weight: weight)
    }
    
    static func tabBarText(
        weight: Font.Weight = .medium) -> Font {
        .system(size: 10, weight: weight)
    }
}
