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
//    @Published var items: [String] = []
    @Published var isLoading = false
    @Published var hasMoreData = true
    private var currentPage = 1

    init() {
//        fetchData()
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
                                                                        category: .technology,
                                                                        country: "us"
            )

            let articlesAPI = response.articles ?? []
            articlesAPI.forEach { items.append(.init(Article.toArticle(dto: $0))) }
            currentPage += 1
            // Simulate no more data on page 3
            self.hasMoreData = self.currentPage < 5


            self.isLoading = false
            self.currentPage += 1
            return items

        } catch {
            print(error)
        }
        return []
    }

    // MARK: - DATA
//    func fetchData() {
//        // Prevent multiple simultaneus requests
//        guard !isLoading else { return }
//        print("_________________________")
//        print("🚀 Start fetching data...")
//
//        isLoading = true
//
//        // Simulate network delay
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//            // Simulate paginated response
//            let newItems = (1...20)
//                .map { "Item \((self.currentPage - 1) * 20 + $0)"}
//
//            self.items.append(contentsOf: newItems)
//            print("items: \(self.items)")
//            print("_________________________")
//            print("fetched: \(self.items.count)")
//
//
//            // Simulate no more data on page 3
//            self.hasMoreData = self.currentPage < 12
//
//
//            self.isLoading = false
//            self.currentPage += 1
//
//            print("Has more data? \(self.hasMoreData)")
//            print("Is Loading? \(self.isLoading)")
//            print("Current page: \(self.currentPage)")
//        }
//    }
}
