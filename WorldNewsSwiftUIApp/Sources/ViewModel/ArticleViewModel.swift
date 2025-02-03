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
    var saveDb: Bool = false
}

struct TaskUpdater: Equatable {
    var id: Date
    var category: Category
}

@MainActor
class ArticleViewModel: ObservableObject {
    // MARK: - PROPERTIES
    @Published var taskUpdater: TaskUpdater
    @Published var state: CurrentState<Article> = .empty

    @Published var articles: [Article] = []

    @Published var isLoading = false
    @Published var hasMoreData = true

    private var isBookmarked: Bool = false

    private var query = QueryParameters(
        pageSize: 10,
        page: 1,
        isOnline: true,
        withDelay: false,
        language: "us",
        saveDb: true
    )

    static let shared = ArticleViewModel()

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


    func loadArticles() async {
        isTaskIsCancelled
        state = .empty
        do {
            let articles = try await fetch(with: taskUpdater.category)
            state = .loaded(articles)
            isTaskIsCancelled
        } catch {
            isTaskIsCancelled
            state = .error(error)
            print("Failed to fetch data: \(error.localizedDescription)")
        }
    }

    func remove(_ id: String) async {
        if case let .loaded(articles) = state {
            let deleted = articles.filter {$0.id != id}
            state = .loaded(deleted)
        }
    }

    var isTaskIsCancelled: Void {
        if Task.isCancelled {
            print("TASK IS CANCELLED")
            return
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

            let response =  try await ArticleAPIClient()
                .getTopHeadline(query: query, category: category)

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


    private func logs(totalPages: Int, totalResults: Int) {
        print("Total pages: \(totalPages)")
        print("Total results: \(totalResults)")
        print("Total items: \(articles.count)")
        print("Current page: \(query.page)")
    }

}


extension Notification.Name {
    static let didBookmarkArticle = Notification.Name("didBookmarkArticle")
}

extension ArticleViewModel {
    func post(_ article: Article) {
        NotificationCenter.default.post(name: .didBookmarkArticle, object: self, userInfo: ["article": article])
    }


}
