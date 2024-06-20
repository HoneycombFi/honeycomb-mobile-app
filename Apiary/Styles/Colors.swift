import SwiftUI

extension Color {
    static let primaryYellow = Color(hex: "0xFFCB31")
    static let lightBlue = Color(hex: "0x9D7DFF")
    static let mediumBlue = Color(hex: "0x7DDFFF")
    static let lightGray = Color(hex: "0x9E9E9E")
    static let lightPurple = Color(hex: "0xED72D5")
    static let green = Color(hex: "0x61C555")
    static let red = Color(hex: "0xEC6A5E")

    init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.currentIndex = hex.startIndex
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        let red = Double((rgbValue & 0xff0000) >> 16) / 255.0
        let green = Double((rgbValue & 0xff00) >> 8) / 255.0
        let blue = Double(rgbValue & 0xff) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: 1)
    }
}
