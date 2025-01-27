import Foundation

enum Category: String, CaseIterable {
    case science
//    case technology
//    case entertainment
    case health
    case general
//    case business
//    case sports

}

extension Category: Identifiable {
    var id: Self { self }
}
