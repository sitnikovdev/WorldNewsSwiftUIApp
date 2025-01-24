//
//  Category.swift
//  XCANews
//
//  Created by Alfian Losari on 6/27/21.
//

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
