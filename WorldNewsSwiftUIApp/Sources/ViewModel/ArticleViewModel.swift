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

struct TaskUpdater: Equatable {
    var id: Date
    var category: Category
}

@MainActor
class ArticleViewModel: ObservableObject {
    // MARK: - PROPERTIES
    @Published var category: Category = .science
    @Published var taskUpdater = TaskUpdater(id: .now, category: .science)
    @Published var state: CurrentState<Article> = .empty

    @Published var articleItems: [Article] = []

    @Published var isLoading = false
    @Published var hasMoreData = true


    private var query = QueryParameters(
        pageSize: 10,
        page: 1,
        isOnline: true,
        withDelay: false,
        language: "us"
    )


    init(articles: [Article]? = nil,
         category: Category = .science
    ) {
        if let articles = articles {
            state = .loaded(articles)
        } else {
            state = .empty
        }
        self.taskUpdater = .init(id: .now, category: category)
    }

    //    init() {
    //        Task {
    //            try await getNewsWithCategory()
    //        }
    //    }

    func loadArticles() async {
        do {
            let articles = try await fetch(with: taskUpdater.category)
            state = .loaded(articles)
        } catch {
            state = .error(error)
            print("Failed to fetch data: \(error.localizedDescription)")
        }
    }


    // MARK: - RETURN ARTICLE FROM API CALL
    func fetch(with category: Category ) async throws -> [Article] {

        print("API Call with Real Data ")
        print("_________________________")
        print("🚀 Start fetching data with category: \(category)...")
        do {

            isLoading = true
            state = .loading

            let response =  try await ArticleAPIClient().getTopHeadline(page: query.page,
                                                                        pageSize: query.pageSize,
                                                                        category: category,
                                                                        country: query.language,
                                                                        withDelay: query.withDelay,
                                                                        isOnline: query.isOnline
            )

            let articlesAPI = response.articles ?? []
            var articles: [Article] = []
            articlesAPI.forEach { articles.append($0) }

            let  totalResults = response.totalResults ?? 0
            let totalPages = Int(ceil(Double(totalResults) / 10.0))
            self.hasMoreData = query.page < totalPages

            logs(totalPages: totalPages, totalResults: totalResults)

            self.isLoading = false
            state = .loaded(articles)
            query.page += 1
            return articles

        } catch {
            print(error)
            state = .error(error)
        }
        state = .empty
        return []
    }

    // MARK: - EXTENTION PAGINATION
    func getNewsWithCategory() async throws -> [Article] {

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
            articlesAPI.forEach { articleItems.append($0) }

            let  totalResults = response.totalResults ?? 0
            let totalPages = Int(ceil(Double(totalResults) / 10.0))
            self.hasMoreData = query.page < totalPages

            logs(totalPages: totalPages, totalResults: totalResults)

            self.isLoading = false
            query.page += 1
            return articleItems
            
        } catch {
            print(error)
        }
        return []
    }

    private func logs(totalPages: Int, totalResults: Int) {
        print("Total pages: \(totalPages)")
        print("Total results: \(totalResults)")
        print("Total items: \(articleItems.count)")
        print("Current page: \(query.page)")
    }

}

