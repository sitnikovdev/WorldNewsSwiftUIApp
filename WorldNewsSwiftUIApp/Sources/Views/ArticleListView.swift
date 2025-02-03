//
//  PaginatedListView.swift
//  SkeletonLoader
//
//  Created by Oleg Sitnikov on 23.01.25.
//

import SwiftUI
import Combine


struct ArticleListView: View {
    @EnvironmentObject var articleVM: ArticleViewModel
    @EnvironmentObject var bookmarkVM: ArticleBookmarkViewModel
    @State private var cancellable: AnyCancellable?
    @Binding  var isFavorite: Bool

    var articles: [Article]
    private func animateBookmarked() {
        cancellable = NotificationCenter.default.publisher(for: .didBookmarkArticle)
            .map { notification in
                notification.userInfo?["article"]
            }
            .first()
            .compactMap { $0 as? Article } // Filter out nil values
            .sink { recived in
                isFavorite = bookmarkVM.isBookmarked(recived)
                print("isFavorite in List: \(isFavorite)")
                print("id: \(recived)")

                Task {
                    //                            await remove(for: id)
                }
            }
    }


    var body: some View {



        VStack {
            List {
                //TODO: -FIX SCELETON
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
                    //                        .scaleEffect(isFavorite  ? 0.3 : 1)
                    //                        .offset(x: isFavorite ? 130 : 0,
                    //                                y: isFavorite  ? 500 : 0)
                    //                        .rotation3DEffect(isFavorite ?  .degrees(360.0) : .degrees(0), axis: (x: 1, y: 0, z: 0))
                    //                        .zIndex(isFavorite ? 3 : 0)
                    //                        .animation(.snappy, value: isFavorite)
                        .onAppear {
                            if  case .loaded = articleVM.state,
                                item == articles.last {
                                Task {
                                    await articleVM.loadArticles()
                                }
                            }

                            // TODO: - Animate bookmarked article
                            animateBookmarked()

                        }
                }
            }
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            .listRowSeparator(.hidden)

        }
        .listStyle(.plain)
    }
}




