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
typealias ArticleDTO = Components.Schemas.Article

struct ArticleItem: Identifiable, Hashable {
    let id: Int
    var articleDTO: ArticleDTO?

    init(_ article: ArticleDTO? = nil) {
        self.id = Helper.lastId + 1
        self.articleDTO = article
        Helper.lastId += 1
    }
}
