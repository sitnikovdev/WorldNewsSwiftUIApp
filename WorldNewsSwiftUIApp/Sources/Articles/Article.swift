//
//  Article.swift
//  WorldNewsSwiftUIApp
//
//  Created by Oleg Sitnikov on 21.01.25.
//

import Foundation


fileprivate let relativeDateFormatter: RelativeDateTimeFormatter = .init()
typealias Source = Components.Schemas.Source


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

    static func toArticle(dto: ArticleAPI) -> Article {
        return Article(
            source: .init(),
            author: dto.author ?? "",
            title: dto.title ?? "",
            description: dto.description ?? "",
            url: dto.url,
            imageUrl: dto.urlToImage,
            publishedAt: dto.publishedAt?.toDate() ?? .now,
            content: dto.content ?? ""
        )
    }



    static let mockData: [Article] = [
        Article(
            author: "Test author",
            title: "Test title",
            description: "Test description",
            url: "https://www.google.com",
            imageUrl: "https://via.placeholder.com/150",
            publishedAt: Date(),
            content: "Test content"
        ),
        Article(
            author: "Test author 2",
            title: "Test title 2",
            description: "Test description 2",
            url: "https://www.google.com",
            imageUrl: "https://via.placeholder.com/150",
            publishedAt: Date(),
            content: "Test content 2"
        ),
        Article(
            author: "Test author 3",
            title: "Test title 3",
            description: "Test description 3",
            url: "https://www.google.com",
            imageUrl: "https://via.placeholder.com/150",
            publishedAt: Date(),
            content: "Test content 3"
        ),
        Article(
            author: "Test author 4",
            title: "Test title 4",
            description: "Test description 4",
            url: "https://www.google.com",
            imageUrl: "https://via.placeholder.com/150",
            publishedAt: "2021-01-01T00:00:00Z".toDate() ?? .now,
            content: "Test content 4"),
        Article(
            author: "Test author 5",
            title: "Test title 5",
            description: "Test description 5",
            url: "https://www.google.com",
            imageUrl: "https://via.placeholder.com/150",
            publishedAt: "2021-01-01T00:00:00Z".toDate() ?? .now,
            content:"Test content 5"
        ),
        Article(
            author: "Test author 6",
            title: "Test title 6",
            description: "Test description 6",
            url: "https://www.google.com",
            imageUrl: "https://via.placeholder.com/150",
            publishedAt: "2021-01-01T00:00:00Z".toDate() ?? .now,
            content: "Test content 6"
        ),
        Article(
            author: "Test author 7",
            title: "Test title 7",
            description: "Test description 7",
            url: "https://www.google.com",
            imageUrl: "https://via.placeholder.com/150",
            publishedAt: "2021-01-01T00:00:00Z".toDate() ?? .now,
            content: "Test content 7"
        ),
        Article(
            author: "Test author 8",
            title: "Test title 8",
            description: "Test description 8",
            url: "https://www.google.com",
            imageUrl: "https://via.placeholder.com/150",
            publishedAt: "2021-01-01T00:00:00Z".toDate() ?? .now,
            content: "Test content 8"
        ),
        Article(
            author: "Test author 9",
            title: "Test title 9",
            description: "Test description 9",
            url: "https://www.google.com",
            imageUrl: "https://via.placeholder.com/150",
            publishedAt: "2021-01-01T00:00:00Z".toDate() ?? .now,
            content: "Test content 9"
        ),
    ]
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
