//
//  WorldNewsViewModel.swift
//  WorldNewsSwiftUIApp
//
//  Created by Oleg Sitnikov on 09.01.25.
//

import Foundation

@MainActor
class WorldNewsViewModel: ObservableObject {
//    @Published var news: [News] = []
    @Published var greeting: String = "Hello, Stranger!"
    @Published var news: [Components.Schemas.Article] = []

    
    func fetchNews() {
        Task {
            greeting = try await WorldNewsClient().getGreeting(name: "News")
        }
    }

    func getNews() async  -> [Components.Schemas.Article] {
       do {
           news =  try await WorldNewsClient().getNews()
           return news
        } catch {
           print(error)
           return []
       }
    }
}
