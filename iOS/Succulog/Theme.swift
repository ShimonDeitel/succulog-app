import SwiftUI

enum Theme {
    static let background = Color(red: 0.114, green: 0.090, blue: 0.063)
    static let accent = Color(red: 0.780, green: 0.482, blue: 0.294)
    static let accent2 = Color(red: 0.561, green: 0.627, blue: 0.361)
    static let cardBackground = Color(.secondarySystemGroupedBackground)

    static let titleFont = Font.system(.title2, design: .rounded).weight(.bold)
    static let headlineFont = Font.system(.headline, design: .rounded)
    static let bodyFont = Font.system(.body, design: .rounded)
    static let captionFont = Font.system(.caption, design: .rounded)
}
