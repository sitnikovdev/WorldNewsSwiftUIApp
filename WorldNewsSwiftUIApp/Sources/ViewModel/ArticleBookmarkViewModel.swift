//
//  ArticleBookmarkViewModel.swift
//  WorldNewsSwiftUIApp
//
//  Created by Oleg Sitnikov on 28.01.25.
//

import Foundation


@MainActor
class ArticleBookmarkViewModel: ObservableObject {
    @Published private(set) var bookmarks: [Article] = []
    private let bookmarksStore: PlistDataStore<[Article]> = .init(filename: "bookmarks")

    static let shared = ArticleBookmarkViewModel()
    private init() {
        Task {
            await load()
        }
    }

    private func load() async  {
        bookmarks = await bookmarksStore.load() ?? []
    }

    func isBookmarked(_ article: Article) -> Bool {
        bookmarks.firstIndex(where: { $0.id == article.id }) != nil
    }

    func addBookmark(_ article: Article)  {
        guard !isBookmarked(article) else { return }
        bookmarks.insert(article, at: 0)
        bookmarkUpdated()
    }

    func removeBookmark(for article: Article) {
        guard let index = bookmarks.firstIndex(where: { $0.id == article.id }) else { return }
        bookmarks.remove(at: index)
        bookmarkUpdated()
    }


    func bookmarkUpdated()  {
        let bookmarks = self.bookmarks
        Task {
            await bookmarksStore.save(bookmarks)
        }
    }

}
