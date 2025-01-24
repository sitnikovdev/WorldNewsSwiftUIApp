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
        NavigationView {
            List {
                // Display skeleton loader if items are not loadded
                if viewModel.items.isEmpty && viewModel.isLoading {
                    ForEach(0..<5, id: \.self) { _ in
                        SkeletonLoaderView()
                    }
                }
                Text("Custom Picker: Vertical Items")
                NewsCategorySelector(
                    Category.allCases,
                    selection: selectedItem,
                    indicatorBuilder: {
                        GeometryReader { geo in
                            Rectangle()
                                .foregroundColor(.white)
                                .cornerRadius(6.0)
                                .padding(1)
                                .frame(width: geo.size.width / CGFloat(Category.allCases.count))
                                .shadow(color: .black.opacity(0.1), radius: 2, x: 1, y: 1)
                                .animation(.spring().speed(1.5))
                                .offset(x: geo.size.width / CGFloat(Category.allCases.count) * CGFloat(Category.allCases.firstIndex(of: selectedItem!)!), y: 0)
                        }.frame(height: 64)
                    }
                ) { item in
                    CategoryItem(
                        item: item,
                        isSelected: selectedItem == item
                    )
                    .padding(.vertical, 8)

                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.150)) {
                            selectedItem = item
                        }
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
