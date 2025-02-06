//
//  BookmarkTabView.swift
//  WorldNewsSwiftUIApp
//
//  Created by Oleg Sitnikov on 28.01.25.
//

import SwiftUI

struct BookmarkTabView: View {
    @EnvironmentObject var articleBookmarkViewModel: ArticleBookmarkViewModel
    @State var searchText: String = ""


    var body: some View {
            BookmarkListView(articles: articles)
                .navigationTitle("Bookmarks")
    }

    private var articles: [Article] {
        if searchText.isEmpty {
            return articleBookmarkViewModel.bookmarks
        }
        return articleBookmarkViewModel.bookmarks.filter {
            $0.titleText.lowercased().contains(searchText.lowercased())
            ||
            $0.descriptionText.lowercased().contains(searchText.lowercased())
        }
    }
}

#Preview {
    BookmarkTabView()
}
