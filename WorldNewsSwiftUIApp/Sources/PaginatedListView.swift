//
//  PaginatedListView.swift
//  SkeletonLoader
//
//  Created by Oleg Sitnikov on 23.01.25.
//

import SwiftUI

struct PaginatedListView: View {
    // MARK: - PROPRERTIES
    @State var progressViewId: Int = 0 // Fix bug with empty ProgressView
    @StateObject private var viewModel = PaginatedDataViewModel()

    // MARK: - BODY
    var body: some View {
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
                    Text(item.article.title ?? "No title")
                        .padding()
                        .onAppear {
                            if !viewModel.items.isEmpty
                                && item == viewModel.items.last
                                && viewModel.hasMoreData
                                && !viewModel.isLoading
                            {
                                print("on appear: item == viewModel.items.last")
//                                viewModel.fetchData()
                                Task {
                                    await viewModel.getNewsWithPaggination()
                                }
                            }
                            progressViewId += 1
                        }
                }

                if viewModel.isLoading {
                    VStack  {
                        ProgressView()
                            .id(progressViewId)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                            .scaleEffect(1.5)
                    }
                }
            }
            .navigationTitle("Paginate Items: \(viewModel.items.count)")
        }
    }

}


#Preview {
    PaginatedListView()
}
