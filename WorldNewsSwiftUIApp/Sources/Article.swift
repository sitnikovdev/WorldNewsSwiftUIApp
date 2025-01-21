//
//  Article.swift
//  WorldNewsSwiftUIApp
//
//  Created by Oleg Sitnikov on 21.01.25.
//

import Foundation

struct Article {

    let title: String?
    let description: String?
    let imageUrl: String?
    let url: String?
    let publishedAt: Date?
    let author: String?
    let content: String?

    init(title: String?, description: String?, imageUrl: String?, url: String?, publishedAt: Date?, author: String?, content: String?) {
        self.title = title
        self.description = description
        self.imageUrl = imageUrl
        self.url = url
        self.publishedAt = publishedAt
        self.author = author
        self.content = content
    }
}
