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
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("News count: \(articles.count)")
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
