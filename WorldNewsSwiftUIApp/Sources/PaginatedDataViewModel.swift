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
            await getNewsWithPaggination()
        }
    }

    // MARK: - EXTENTION PAGINATION
    func getNewsWithPaggination() async  -> [ArticleItem] {
        print("API Call with Real Data ")
        print("_________________________")
        print("🚀 Start fetching data...")
        do {

            isLoading = true
            let response =  try await ArticleAPIClient().getTopHeadline(page: currentPage,
                                                                        pageSize: 10,
                                                                        category: .science,
                                                                        country: "us"
            )

            let articlesAPI = response.articles ?? []
            articlesAPI.forEach { items.append(.init(Article.toArticle(dto: $0))) }
            currentPage += 1

            let  totalResults = response.totalResults ?? 0
            let totalPages = Int(ceil(Double(totalResults) / 10.0))
            self.hasMoreData = self.currentPage <= totalPages

            self.isLoading = false
            self.currentPage += 1
            return items

        } catch {
            print(error)
        }
        return []
    }
}
