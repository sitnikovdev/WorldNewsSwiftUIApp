//
//  ArticleAPI.swift
//  WorldNewsSwiftUIApp
//
//  Created by Oleg Sitnikov on 22.01.25.
//

import Foundation

struct ArticleResponseAPI: Codable {
    /// - Remark: Generated from `#/paths/everything/GET/responses/200/content/json/status`.
    internal var status: Swift.String?
    /// - Remark: Generated from `#/paths/everything/GET/responses/200/content/json/totalResults`.
    internal var totalResults: Swift.Int?
    /// - Remark: Generated from `#/paths/everything/GET/responses/200/content/json/articles`.
    internal var articles: [ArticleAPI]?
    /// Creates a new `JsonPayload`.
    ///
    /// - Parameters:
    ///   - status:
    ///   - totalResults:
    ///   - articles:
    internal init(
        status: Swift.String? = nil,
        totalResults: Swift.Int? = nil,
        articles: [ArticleAPI]? = nil
    ) {
        self.status = status
        self.totalResults = totalResults
        self.articles = articles
    }
    internal enum CodingKeys: String, CodingKey {
        case status
        case totalResults
        case articles
    }
}

struct ArticleAPI: Codable {

    let source: Source?
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?

    init(
        source: Source? = nil,
        author: String?,
        title: String?,
        description: String?,
        url: String?,
        toImageUrl: String?,
        publishedAt: String?,
        content: String?
    ) {
        self.source = source
        self.author = author
        self.title = title
        self.description = description
        self.url = url
        self.urlToImage = toImageUrl
        self.publishedAt = publishedAt
        self.content = content
    }
}
