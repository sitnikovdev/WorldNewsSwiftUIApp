//
//  PaginatedListView.swift
//  SkeletonLoader
//
//  Created by Oleg Sitnikov on 23.01.25.
//

import SwiftUI

typealias NewsCategoryQuery = Operations.GetTopHeadlines.Input.Query.CategoryPayload

struct PaginatedListView: View {
    // MARK: - PROPRERTIES
    @State var progressViewId: Int = 0 // Fix bug with empty ProgressView
    @StateObject private var viewModel =
    PaginatedDataViewModel()
    @State private var selectedItem : Category = .science
    @State private var title: String = "Loading..."
    @State private var newsCategory: NewsCategoryQuery = .science

    // MARK: - BODY
    var body: some View {
//        if !viewModel.items.isEmpty {
            NewsCategorySelectorView(selectedItem: $selectedItem)
//        }
        NavigationView {
            List {

                // Display skeleton loader if items are not loadded
                if viewModel.items.isEmpty && viewModel.isLoading {
                    ForEach(0..<5, id: \.self) { _ in
                        SkeletonLoaderView()
                    }
                }

                // Display the actual items
                ForEach(viewModel.items, id: \.self) { item in
                    NavigationLink(destination: ArticleDetailView(article: item.article)) {
                        ArticleView(article: item.article)
                            .padding()
                            .onAppear {
                                title = selectedItem.rawValue.capitalized
                                if !viewModel.items.isEmpty
                                    && item == viewModel.items.last
                                {
                                    print("on appear: item == viewModel.items.last")
                                    Task {
                                        await viewModel.getNewsWithCategory()
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
            .onChange(of: selectedItem) { newValue in
                self.title =  newValue.rawValue.capitalized
                var newsCategory: NewsCategoryQuery
                switch selectedItem {
                case .science:
                    newsCategory = .science
                case .general:
                    newsCategory = .general
                case .health:
                    newsCategory = .health
                }
                print("-----------------------------------")
                print("On Category Change: \(newsCategory)")
                print("items: \(viewModel.items)")

                print("remove items...")
                viewModel.category = newsCategory
                viewModel.items.removeAll()
                print("items: \(viewModel.items)")
                Task {
                    print("request to server...")
                    await viewModel.getNewsWithCategory()
                }
                print("items updated: \(viewModel.items)")
            }
            .navigationTitle($title)
        }
    }

}


#Preview {
    PaginatedListView()
}
