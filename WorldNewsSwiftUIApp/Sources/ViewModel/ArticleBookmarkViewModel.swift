//
//  ArticleBookmarkViewModel.swift
//  WorldNewsSwiftUIApp
//
//  Created by Oleg Sitnikov on 28.01.25.
//

import Foundation


class ArticleBookmarkViewModel: ObservableObject {
    @Published private(set) var bookmarks: [Article] = []
    private let bookmarksStorage: String = ""

}
