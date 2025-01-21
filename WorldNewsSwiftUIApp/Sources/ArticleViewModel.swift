//
//  WorldNewsViewModel.swift
//  WorldNewsSwiftUIApp
//
//  Created by Oleg Sitnikov on 09.01.25.
//

import Foundation

@MainActor
@Observable
class ArticleViewModel {
    var articles: [ArticleItem] = []
    private var currentPage: Int = 1
    private var totalResults: Int = 0


    func getNews() async  -> [ArticleItem] {
       do {
           let response =  try await ArticleAPIClient().getTopHeadline(page: currentPage)
//           let response =  try await WorldNewsClient().getNewsResponse(page: currentPage)
           totalResults = response.totalResults ?? 0

           let articlesAPI = response.articles ?? []
           articlesAPI.forEach { articles.append(.init($0)) }
           print("total results: \(totalResults)")
           print("page: \(currentPage)")
           print("item id: \(articles.last?.id ?? 0)")
           currentPage += 1
           return articles
        } catch {
           print(error)
           return []
       }
    }
}
