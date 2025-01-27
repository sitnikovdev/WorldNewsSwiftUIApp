//
//  Article.swift
//  WorldNewsSwiftUIApp
//
//  Created by Oleg Sitnikov on 21.01.25.
//

import Foundation


fileprivate let relativeDateFormatter: RelativeDateTimeFormatter = .init()

typealias ArticleDTO = Components.Schemas.Article
typealias Source = Components.Schemas.Source
typealias NewsCategoryQuery = Operations.GetTopHeadlines.Input.Query.CategoryPayload


struct Article {

    let source: Source
    let author: String
    let title: String
    let description: String
    let url: String?
    let toImageUrl: String?
    let publishedAt: Date
    let content: String

    init(
        source: Source = .init(),
        author: String,
        title: String,
        description: String,
        url: String?,
        imageUrl: String?,
        publishedAt: Date,
        content: String
    ) {
        self.source = source
        self.author = author
        self.title = title
        self.description = description
        self.url = url
        self.toImageUrl = imageUrl
        self.publishedAt = publishedAt
        self.content = content
    }

    var imageURL: URL? {
        guard let urlString = toImageUrl else { return nil }
        return URL(string: urlString)
    }

    var articleURL: URL? {
        guard let urlString = url else { return nil }
        return URL(string: urlString)
    }

    var dateCaption: String {
        "\(relativeDateFormatter.localizedString(for: publishedAt, relativeTo: .now))"
            .trimmingCharacters(in: .whitespaces)
    }

    func toDTO() -> ArticleDTO {
        return ArticleDTO(
            source: .init(),
            author: author,
            title: title,
            description: description,
            url: url,
            urlToImage: toImageUrl,
            publishedAt: publishedAt,
            content: content
        )
    }

    static func toArticle(dto: ArticleDTO) -> Article {
        return Article(
            source: .init(),
            author: dto.author ?? "",
            title: dto.title ?? "",
            description: dto.description ?? "",
            url: dto.url,
            imageUrl: dto.urlToImage,
            publishedAt: dto.publishedAt ?? .now,
            content: dto.content ?? ""
        )
    }

}

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
}
