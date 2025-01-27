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
                ArticleListView()
                    .task(id: viewModel.category, loadArticles)
                    .refreshable(action: refresh)
                    .navigationTitle(viewModel.category.rawValue)
            }
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
