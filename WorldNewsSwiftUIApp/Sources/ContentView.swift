//
//  ContentView.swift
//  WorldNewsSwiftUIApp
//
//  Created by Oleg Sitnikov on 08.01.25.
//

import SwiftUI
import Foundation

struct ContentView: View {
    var viewModel = WorldNewsViewModel()
    @State var articles: [ArticleItem] = []

    var body: some View {
        List {
            ForEach(articles) { article in
                    if let title = article.title {
                        Text("id: \(article.id)")
                        Text(title)
                            .onAppear {
                                Task {
                                    if articles.isNearElement(article) {
                                        print("getNews called")
                                        articles = await viewModel.getNews()
                                     }
                                }
                            }
                    }

            }
        }
        .onAppear {
            Task {
                articles =  await viewModel.getNews()
            }
    }
        .padding()
    }

}
