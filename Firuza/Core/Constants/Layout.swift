import SwiftUI

enum Layout {
    
    static let screenHorizontalPadding: CGFloat = 16
    static let cornerRadius: CGFloat = 24
    static let buttonHeight: CGFloat = 56
    static let cardSpacing: CGFloat = 12
    static let sectionSpacing: CGFloat = 32
}

enum AppLayout {
    
    static let designWidth: CGFloat = 390
    
    private static var scale: CGFloat {
        UIScreen.main.bounds.width / designWidth
    }
    
    static var ringSize: CGFloat {
        min(226*scale, 226)
    }
    
    static var ringLineWidth: CGFloat = 12
}
