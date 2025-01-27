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
    @State private var newsCategory: Category = .science
    @State private var title: String = "Loading..."

    var body: some View {
        CategorySelectorView(selectedItem: $newsCategory)
        NavigationView {
            List {
                ArticleListView()
                    .onChange(of: newsCategory) { newValue in
                        self.title =  newValue.rawValue.capitalized

                        viewModel.category = newsCategory
                        Task {
                            try await viewModel.getNewsWithCategory()
                        }
                        print("items updated: \(viewModel.articleItems)")
                    }
                    .navigationTitle($title)
                    .navigationBarTitleDisplayMode(.inline)
            }
        }

    }
}

#Preview {
    ContentView()
}
