//
//  PaginatedListView.swift
//  SkeletonLoader
//
//  Created by Oleg Sitnikov on 23.01.25.
//

import SwiftUI


struct ArticleListView: View {
    // MARK: - PROPRERTIES
    let articles: [Article]
    @StateObject private var viewModel = ArticleViewModel()
    @State var progressViewId: Int = 0 // Fix bug with empty ProgressView


    // MARK: - BODY
    var body: some View {

                // Display skeleton loader if items are not loadded
                if articles.isEmpty && viewModel.isLoading {
                    ForEach(0..<5, id: \.self) { _ in
                        SkeletonLoaderView()
                    }
                }

                // Display the actual items
                ForEach(articles, id: \.self) { item in
                    NavigationLink(destination: ArticleDetailView(article: item)) {
                        ArticleView(article: item)
                            .padding()
//                            .onAppear {
//                                if !articles.isEmpty
//                                    && item == articles.last
//                                {
//                                    Task {
//                                        try await viewModel.getNewsWithCategory()
//                                    }
//                                }
//                                progressViewId += 1
//                            }
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

    }



