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
    @State private var selectedItem : Category? = .science

    // MARK: - BODY
    var body: some View {
        NewsCategorySelectorView(selectedItem: selectedItem)
//        Picker("Categories", selection: $selectedItem) {
//            ForEach(Category.allCases, id: \.self) { category in
//                Text(category.rawValue).tag(category)
//            }
//        }
        .pickerStyle(SegmentedPickerStyle())
        .onChange(of: selectedItem) { newValue in }
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
                    ArticleView(article: item.article)
                        .padding()
                        .onAppear {
                            if !viewModel.items.isEmpty
                                && item == viewModel.items.last
                            {
                                print("on appear: item == viewModel.items.last")
                                Task {
                                    await viewModel.getNewsWithPaggination()
                                }
                            }
                            progressViewId += 1
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
            .navigationTitle("Paginate Items: \(viewModel.items.count)")
        }
    }

}


#Preview {
    PaginatedListView()
}
