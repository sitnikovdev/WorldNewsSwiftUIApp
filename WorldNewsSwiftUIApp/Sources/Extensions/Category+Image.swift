import Foundation
import SwiftUI

extension CategoryQuery {
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
