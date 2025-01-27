//
//  ContentView.swift
//  WorldNewsSwiftUIApp
//
//  Created by Oleg Sitnikov on 08.01.25.
//

import SwiftUI
import Foundation

struct ContentView: View {
    @StateObject private var viewModel = ArticleViewModel()
    @State private var title: String = "Loading..."

    var body: some View {
        CategorySelectorView(selectedItem: $viewModel.category)
        NavigationView {
            List {
                ArticleListView(articles: articles)
                    .overlay(overlayView)
                    .task(id: viewModel.category, loadArticles)
                    .refreshable(action: refresh)
                    .navigationTitle(viewModel.category.rawValue)
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
        await viewModel.loadArticles()
    }
}

#Preview {
    ContentView()
}
