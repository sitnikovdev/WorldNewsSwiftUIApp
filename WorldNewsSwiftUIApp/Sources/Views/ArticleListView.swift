//
//  PaginatedListView.swift
//  SkeletonLoader
//
//  Created by Oleg Sitnikov on 23.01.25.
//

import SwiftUI


struct ArticleListView: View {
    // MARK: - PROPRERTIES
    @StateObject private var viewModel = ArticleViewModel()
    @State private var newsCategory: Category = .science

    @State var progressViewId: Int = 0 // Fix bug with empty ProgressView
    @State private var title: String = "Loading..."


    // MARK: - BODY
    var body: some View {
        CategorySelectorView(selectedItem: $newsCategory)
        NavigationView {
            List {

                // Display skeleton loader if items are not loadded
                if viewModel.articleItems.isEmpty && viewModel.isLoading {
                    ForEach(0..<5, id: \.self) { _ in
                        SkeletonLoaderView()
                    }
                }

                // Display the actual items
                ForEach(viewModel.articleItems, id: \.self) { item in
                    NavigationLink(destination: ArticleDetailView(article: item.article)) {
                        ArticleView(article: item.article)
                            .padding()
                            .onAppear {
                                title = newsCategory.rawValue.capitalized
                                if !viewModel.articleItems.isEmpty
                                    && item == viewModel.articleItems.last
                                {
                                    print("on appear: item == viewModel.items.last")
                                    Task {
                                        try await viewModel.getNewsWithCategory()
                                    }
                                }
                                progressViewId += 1
                            }
                    }
                }
                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                .listRowSeparator(.hidden)

                if viewModel.isLoading {
                    VStack  {
                        ProgressView()
                            .id(progressViewId)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                            .scaleEffect(1.5)
                    }
                }
            }
            .onChange(of: newsCategory) { newValue in
                self.title =  newValue.rawValue.capitalized

                print("-----------------------------------")
                print("On Category Change: \(newsCategory)")
                print("items: \(viewModel.articleItems)")

                print("remove items...")
                viewModel.category = newsCategory
                print("items: \(viewModel.articleItems)")
                Task {
                    print("request to server...")
                   try await viewModel.getNewsWithCategory()
                }
                print("items updated: \(viewModel.articleItems)")
            }
            .navigationTitle($title)
            .navigationBarTitleDisplayMode(.inline)

        }
    }

}


#Preview {
    ArticleListView()
}
