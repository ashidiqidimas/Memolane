import SwiftUI

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
    
    static let primaryColor = Color(hex: 0x6366F1)
    
    static let textPrimary = Color(hex: 0x0F172A)
    static let textSecondary = Color(hex: 0x0F172A, alpha: 0.9)
    static let textTertiary = Color(hex: 0x0F172A,alpha: 0.8)
    
    static let backgroundPrimary = Color(hex: 0xFCFCFD)
    static let backgroundSecondary = Color(hex: 0xF1F5F9)
}
