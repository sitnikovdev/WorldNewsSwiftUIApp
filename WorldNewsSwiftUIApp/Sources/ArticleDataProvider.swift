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

    // MARK: - INIT
    init()  {
        Task {
            await getData()
        }
    }


    // MARK: - MOCK DATA
    func setMockData() {
         Article.mockData.forEach {
            articleItems.append(.init($0))
        }
    }
    func setMockData(from dto: [ArticleAPI]) {
         dto.forEach {
             articleItems.append(.init(Article.toArticle(dto: $0)))
        }
    }

    typealias JsonPayload = Operations.GetLatestNews.Output.Ok.Body.JsonPayload

    func setMockDataFromJSON() {
        if let url = Bundle.main.url(forResource: "mockData", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let response = try decoder.decode(ArticleResponseAPI.self, from: data)
                totalResults = response.totalResults ?? 0
                setMockData(from: response.articles ?? [])
            } catch {
                print(error)
            }
        }
    }

    func getMockData() -> [ArticleItem] {
        print("API Call with Mock Data")
        if let url = Bundle.main.url(forResource: "mockData", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let response = try decoder.decode(ArticleResponseAPI.self, from: data)
                totalResults = response.totalResults ?? 0
                setMockData(from: response.articles ?? [])
                return articleItems
            } catch {
                print(error)
            }
        }
        return []
    }

    // MARK: - PAGINATION
    func getNews() async  -> [ArticleItem] {
        print("API Call with Real Data")
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

    func getData() async ->  [ArticleItem] {
       return await getNews()
    }
}
