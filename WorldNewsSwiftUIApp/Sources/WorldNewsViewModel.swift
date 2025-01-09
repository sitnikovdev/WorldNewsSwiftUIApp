//
//  WorldNewsViewModel.swift
//  WorldNewsSwiftUIApp
//
//  Created by Oleg Sitnikov on 09.01.25.
//

import Foundation

@MainActor
class WorldNewsViewModel: ObservableObject {
    @Published var news: [Components.Schemas.Article] = []


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
