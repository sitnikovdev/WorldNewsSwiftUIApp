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
    var article: Article

    init(_ article: Article) {
        self.id = Helper.lastId + 1
        self.article = article
        Helper.lastId += 1
    }


    //MARK: - Equatable
    static func == (lhs: ArticleItem, rhs: ArticleItem) -> Bool {
        return lhs.id == rhs.id
    }

    //MARK: - Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
