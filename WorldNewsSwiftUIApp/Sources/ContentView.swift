//
//  ContentView.swift
//  WorldNewsSwiftUIApp
//
//  Created by Oleg Sitnikov on 08.01.25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = WorldNewsViewModel()
    @State var articles: [Components.Schemas.Article] = []

    var body: some View {
        List {
            ForEach(articles, id: \.self) { article in
                VStack {
                    if let author = article.author {
                        Text(author)
                    }
                    if let title = article.title {
                        Text(title)
                    }
                }
            }
        }
        .onAppear {
            Task {
                articles =  await viewModel.getNews()
                print(articles)
            }
    }
        .padding()
    }

}
