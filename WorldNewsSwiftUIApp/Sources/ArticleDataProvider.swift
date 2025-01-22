//
//  WorldNewsViewModel.swift
//  WorldNewsSwiftUIApp
//
//  Created by Oleg Sitnikov on 09.01.25.
//

import Foundation

@MainActor
@Observable
class ArticleDataProvider {
    // MARK: - PROPERTIES
    private(set) var articleItems: [ArticleItem] = []

    private var currentPage  = 1
    private var totalResults = 0

    init() {
//        setMockData()
    }


    // MARK: - MOCK DATA
    func setMockData() {
         Article.mockData.forEach {
            articleItems.append(.init($0))
        }
    }

    // MARK: - API CALL
    func getNews() async  -> [ArticleItem] {
       do {
           let response =  try await ArticleAPIClient().getTopHeadline(page: currentPage)
//           let response =  try await WorldNewsClient().getNewsResponse(page: currentPage)
           totalResults = response.totalResults ?? 0

           let articlesAPI = response.articles ?? []
           articlesAPI.forEach { articleItems.append(.init(Article.toArticle(dto: $0))) }
           print("total results: \(totalResults)")
           print("page: \(currentPage)")
           print("item id: \(articleItems.last?.id ?? 0)")
           currentPage += 1
           return articleItems
        } catch {
           print(error)
           return []
       }
    }
}
