import Foundation
import SwiftUI

extension Category {
    var selectedColor: Color {
        switch self {
        case .science:
            return .red
//        case .sports:
//            return .blue
//        case .entertainment:
//            return .green
//        case .business:
//            return .orange
        default :
            return .blue
        }
    }
}
