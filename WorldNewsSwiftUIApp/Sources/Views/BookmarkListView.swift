//
//  BookmarkListView.swift
//  WorldNewsSwiftUIApp
//
//  Created by Oleg Sitnikov on 06.02.25.
//

import SwiftUI

struct BookmarkListView: View {
    @EnvironmentObject var bookmarkVM: ArticleBookmarkViewModel
    @State private var bookmarked: Article?

    var articles: [Article]

    var body: some View {

        VStack {
            List {
                if articles.isEmpty {
                    ForEach(0..<5, id: \.self) { _ in
                        SkeletonLoaderView()
                    }
                }
                ForEach(articles, id: \.id) { item in
                    ArticleItemView(article: item)
                        .background(
                            NavigationLink("", destination: ArticleDetailView(article: item))
                                .opacity(0) // Hide the NavigationLink
                        )
                }
            }
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            .listRowSeparator(.hidden)

        }
        .listStyle(.plain)
    }
}
