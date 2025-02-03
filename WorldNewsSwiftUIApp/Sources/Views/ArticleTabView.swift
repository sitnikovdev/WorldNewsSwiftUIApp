//
//  NewsTabView.swift
//  WorldNewsSwiftUIApp
//
//  Created by Oleg Sitnikov on 28.01.25.
//

import SwiftUI
import Combine

struct ArticleTabView: View {
    @EnvironmentObject private var viewModel: ArticleViewModel
    @State private var title: String = "Loading..."
    @State private var cancellable: AnyCancellable?
    @State private var isFavorite = false

    func remove(for id: String) async  {
        await viewModel.remove(id)
    }

    var body: some View {
        NavigationView {
            VStack {
                CategorySelectorView(selectedItem: $viewModel.taskUpdater.category)
                ArticleListView(isFavorite: $isFavorite, articles: articles)
                    .overlay(overlayView)
                    .task(id: viewModel.taskUpdater, loadArticles)
                    .refreshable(action: refresh)
                    .navigationTitle(viewModel.taskUpdater.category.rawValue.capitalized)
                    .onAppear {
                        removeBookmarked()
                    }
            }
        }

    }

    private func removeBookmarked() {
        cancellable = NotificationCenter.default.publisher(for: .didBookmarkArticle)
            .map { notification in
                notification.userInfo?["id"]
            }
            .sink { recived in
                if  let id = recived as? String   {

                    print("isFavorite: \(isFavorite)")
                    print("id: \(id)")
                    Task {
                        await remove(for: id)
                    }

                }
            }
    }

    var articles: [Article] {

        if case let .loaded(articles) = viewModel.state {
            return articles
        } else {
            return []
        }
    }

    @ViewBuilder
    private var overlayView: some View {
        switch viewModel.state {
        case .loading:
            ProgressView()
        case .error(let error):
            Text("Error: \(error)")
        case .loaded:
            EmptyView()
        case .empty:
            Text("No articles found")
        }
    }

    @Sendable
    func loadArticles() async {
        await viewModel.loadArticles()
    }

    @Sendable
    func refresh() async {
        viewModel.taskUpdater = .init(id: .now, category: viewModel.taskUpdater.category)
    }
}

