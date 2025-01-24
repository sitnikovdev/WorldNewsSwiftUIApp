//
//  PaginatedDataViewModel.swift
//  SkeletonLoader
//
//  Created by Oleg Sitnikov on 23.01.25.
//

import Foundation

@MainActor
class PaginatedDataViewModel: ObservableObject {
    // MARK: - PROPERTIES
    @Published var items: [ArticleItem] = []
    @Published var isLoading = false
    @Published var hasMoreData = true
    private var currentPage = 1

    init() {
        Task {
            await getNewsWithCategory(.science)
        }
    }

    // MARK: - EXTENTION PAGINATION
    func getNewsWithCategory(_ category: NewsCategoryQuery) async  -> [ArticleItem] {

        print("API Call with Real Data ")
        print("_________________________")
        print("🚀 Start fetching data with category: \(category)...")
        do {

            isLoading = true
            let response =  try await ArticleAPIClient().getTopHeadline(page: currentPage,
                                                                        pageSize: 10,
                                                                        category: category,
                                                                        country: "us"
            )

            let articlesAPI = response.articles ?? []
            articlesAPI.forEach { items.append(.init(Article.toArticle(dto: $0))) }

            let  totalResults = response.totalResults ?? 0
            let totalPages = Int(ceil(Double(totalResults) / 10.0))
            self.hasMoreData = self.currentPage < totalPages

            print("Total pages: \(totalPages)")
            print("Total results: \(totalResults)")
            print("Total items: \(items.count)")
            print("Current page: \(currentPage)")

            self.isLoading = false
            self.currentPage += 1
            return items

        } catch {
            print(error)
        }
        return []
    }
}
