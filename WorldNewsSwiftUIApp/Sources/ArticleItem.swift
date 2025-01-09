//
//  ArticleItem.swift
//  WorldNewsSwiftUIApp
//
//  Created by Oleg Sitnikov on 09.01.25.
//

import Foundation
class Helper {
    static var lastId: Int = 0
}

struct ArticleItem: Identifiable, Hashable {
    let id: Int
    let title: String?
    let description: String?
    let imageUrl: String?
    let url: String?
    let publishedAt: Date?
    let author: String?
    let content: String?

    init(_ article: Components.Schemas.Article? = nil) {
        self.id = Helper.lastId + 1
        Helper.lastId += 1
        self.title = article?.title
        self.description = article?.description
        self.imageUrl = article?.urlToImage
        self.url = article?.url
        self.publishedAt = article?.publishedAt
        self.author = article?.author
        self.content = article?.content
    }
}
