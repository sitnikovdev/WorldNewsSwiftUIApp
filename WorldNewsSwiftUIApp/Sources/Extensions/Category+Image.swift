import Foundation
import SwiftUI

public struct SelectedCategory {
   static let items: [Category] = [
        .science,
        .technology,
        .health,
    ]
}

extension Category {
    var indicatorImage: String {
        switch self {
            
        case .science:
            return "⚛️"
        case .technology:
            return "📡"
        case .entertainment:
            return "🎸"
        case .general:
            return "🌏"
        case .business:
            return "🪙"
        case .sports:
            return "⚽️"
        case .health:
            return "🥗"
        }
    }
}
