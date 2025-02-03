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

    @State var cancellable: AnyCancellable?
    var articles: [Article]

    func remove(for id: String) async  {
        await articleVM.remove(id)
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
                            cancellable = NotificationCenter.default.publisher(for: .didBookmarkArticle)
                                .map { notification in
//                                    print("Notification received: \(notification.userInfo?["id"])")
                                    notification.userInfo?["id"] //as? String
                                }
                                .sink { recived in
                                    if  let id = recived as? String   {
                                        print("recived notification is \(id)")
                                        guard let index = articles.firstIndex(where: { $0.id == id }) else { return }
                                        print("articles count before remove is \(articles.count)")
                                        var newarticles = articles
                                        newarticles.remove(at: index)
                                        print("articles count after remove is \(newarticles.count)")
                                        Task {
                                            await remove(for: id)
                                        }

                                    }
//                                    let article: Article = recived["article"]
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




