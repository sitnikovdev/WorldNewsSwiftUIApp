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
    var progressViewId: Int = 0 // Fix bug with empty ProgressView


    // MARK: - BODY
    var body: some View {

        // Display skeleton loader if items are not loadded
        //                if articles.isEmpty && viewModel.isLoading {

        //TODO: -FIX SCELETON
        //                if articles.isEmpty {
        //                    ForEach(0..<5, id: \.self) { _ in
        //                        SkeletonLoaderView()
        //                    }
        //                }

        List {
            // Display the actual items
            ForEach(articles, id: \.id) { item in
//                NavigationLink(destination: ArticleDetailView(article: item)) {
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
//                }
            }
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            .listRowSeparator(.hidden)

        }
        .listStyle(.plain)
        // TODO: - FIX PROGRESS VIEW
        //                if viewModel.isLoading {
        //                    VStack  {
        //                        ProgressView()
        //                            .id(progressViewId)
        //                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        //                            .scaleEffect(1.5)
        //                    }
        //                }
    }

}



