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
    var indicatorImage: Image {
        switch self {
        case .science:
            return Image(systemName: "atom")
        case .technology:
            return .init(systemName: "iphone")
        case .entertainment:
            return .init(systemName: "film")
        case .general:
            return .init(systemName: "questionmark.circle")
        case .business:
            return .init(systemName: "dollarsign")
        case .sports:
            return .init(systemName: "square.and.arrow.up")
        case .health:
            return .init(systemName: "heart")
        }
    }
}
