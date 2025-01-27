//
//  Article.swift
//  WorldNewsSwiftUIApp
//
//  Created by Oleg Sitnikov on 21.01.25.
//

import Foundation


fileprivate let relativeDateFormatter: RelativeDateTimeFormatter = .init()

typealias Article = Components.Schemas.Article
typealias Source = Components.Schemas.Source
typealias CategoryQuery = Operations.GetTopHeadlines.Input.Query.CategoryPayload


extension String {
    func toDate(format: String = "yyyy-MM-dd'T'HH:mm:ssZ") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)  // UTC time zone
        return dateFormatter.date(from: self)
    }
}


extension Article: Identifiable {
    var id: UUID  {
        UUID()
    }

    var imageURL: URL? {
        guard let urlString = self.urlToImage else { return nil }
        return URL(string: urlString)
    }

    var articleURL: URL? {
        guard let urlString = url else { return nil }
        return URL(string: urlString)
    }

    var dateCaption: String {
        "\(relativeDateFormatter.localizedString(for: self.publishedAt ?? .now, relativeTo: .now))"
            .trimmingCharacters(in: .whitespaces)
    }

    var titleText: String {
        "\(self.title ?? "")"
    }

    var descriptionText: String {
        "\(self.description ?? "")"
    }

    var contentText: String {
        "\(self.content ?? "")"
    }

}
