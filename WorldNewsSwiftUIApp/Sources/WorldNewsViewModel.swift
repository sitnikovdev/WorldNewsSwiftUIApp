//
//  WorldNewsViewModel.swift
//  WorldNewsSwiftUIApp
//
//  Created by Oleg Sitnikov on 09.01.25.
//

import Foundation

@MainActor
class WorldNewsViewModel: ObservableObject {
    @Published var news: [ArticleItem] = []
    private var currentPage: Int = 1
    private var totalResults: Int = 0
    private var statusCode: String?


    func getNews() async  -> [ArticleItem] {
       do {
           let response =  try await WorldNewsClient().getNewsResponse(page: currentPage)
           totalResults = response.totalResults ?? 0
           statusCode = response.status ?? ""

           let articlesAPI = response.articles ?? []
           articlesAPI.forEach { news.append(.init($0)) }
           currentPage += 1
           print("total results: \(totalResults)")
           print("page: \(currentPage)")
           print("item id: \(news.last?.id ?? 0)")
           return news
        } catch {
           print(error)
           return []
       }
    }
}
