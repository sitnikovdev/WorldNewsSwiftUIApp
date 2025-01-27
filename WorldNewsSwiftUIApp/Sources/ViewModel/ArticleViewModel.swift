//
//  PaginatedDataViewModel.swift
//  SkeletonLoader
//
//  Created by Oleg Sitnikov on 23.01.25.
//

import Foundation

enum CurrentState<T> {
    case empty
    case loading
    case loaded([T])
    case error(Error)
}

struct QueryParameters {
    var pageSize: Int
    var page: Int
    var isOnline: Bool = false
    var withDelay: Bool = false
    var language: String = "us"
}


@MainActor
class ArticleViewModel: ObservableObject {
    // MARK: - PROPERTIES
    @Published var items: [ArticleItem] = []
    @Published var isLoading = false
    @Published var hasMoreData = true

    @Published var category: CategoryQuery = .science
    @Published var state: CurrentState<ArticleItem> = .empty

    private var query = QueryParameters(
                            pageSize: 10,
                            page: 1,
                            isOnline: true,
                            withDelay: false,
                            language: "us"
    )


    init() {
        Task {
            await getNewsWithCategory()
        }
    }

    // MARK: - EXTENTION PAGINATION
    func getNewsWithCategory() async  -> [ArticleItem] {

        print("API Call with Real Data ")
        print("_________________________")
        print("🚀 Start fetching data with category: \(category)...")
        do {

            isLoading = true
            let response =  try await ArticleAPIClient().getTopHeadline(page: query.page,
                                                                        pageSize: query.pageSize,
                                                                        category: category,
                                                                        country: query.language,
                                                                        withDelay: query.withDelay,
                                                                        isOnline: query.isOnline
            )

            let articlesAPI = response.articles ?? []
            articlesAPI.forEach { items.append(.init(Article.toArticle(dto: $0))) }

            let  totalResults = response.totalResults ?? 0
            let totalPages = Int(ceil(Double(totalResults) / 10.0))
            self.hasMoreData = query.page < totalPages

            logs(totalPages: totalPages, totalResults: totalResults)

            self.isLoading = false
            query.page += 1
            return items

        } catch {
            print(error)
        }
        return []
    }

    private func logs(totalPages: Int, totalResults: Int) {
        print("Total pages: \(totalPages)")
        print("Total results: \(totalResults)")
        print("Total items: \(items.count)")
        print("Current page: \(query.page)")
    }

}

