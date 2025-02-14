//
//  NewsTabView.swift
//  WorldNewsSwiftUIApp
//
//  Created by Oleg Sitnikov on 28.01.25.
//

import SwiftUI

struct ArticleTabView: View {
    @EnvironmentObject private var viewModel: ArticleViewModel
    @State private var title: String = "Loading..."


    var body: some View {
            VStack {
                CategorySelectorView(selectedItem: $viewModel.taskUpdater.category)
                ArticleListView(articles: articles)
                    .overlay(overlayView)
                    .task(id: viewModel.taskUpdater, loadArticles)
                    .refreshable(action: refresh)
                    .navigationTitle(viewModel.taskUpdater.category.rawValue.capitalized)
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

