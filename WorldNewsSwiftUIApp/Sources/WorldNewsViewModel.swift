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

    init() {
        fetchNews()
    }
    
    func fetchNews() {

        Task {
            greeting = try await WorldNewsClient().getGreeting(name: "News")
        }

    }
}
