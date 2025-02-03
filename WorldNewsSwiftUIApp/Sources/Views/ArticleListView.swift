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
    @State private var cancellable: AnyCancellable?
    @State private var isFavorite: Bool = false

    var articles: [Article]
           private func removeBookmarked() {
            cancellable = NotificationCenter.default.publisher(for: .didBookmarkArticle)
                .map { notification in
                    notification.userInfo?["id"]
                }
                .sink { recived in
                    if  let id = recived as? String   {
                        isFavorite = true
                        Task {
//                            await remove(for: id)
                        }

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
                        .onAppear {
                            if  case .loaded = articleVM.state,
                                item == articles.last {
                                Task {
                                    await articleVM.loadArticles()
                                }
                            }
                           

                        }
                }
            }
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            .listRowSeparator(.hidden)

        }
        .listStyle(.plain)
    }
}




