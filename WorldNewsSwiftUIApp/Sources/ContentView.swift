//
//  ContentView.swift
//  WorldNewsSwiftUIApp
//
//  Created by Oleg Sitnikov on 08.01.25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = WorldNewsViewModel()
    @State var news: [Components.Schemas.Article] = []

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text(viewModel.greeting)
        }
        .onAppear {
            Task {
                viewModel.fetchNews()
                 let articles =  await viewModel.getNews()
                print(articles)
            }
    }
        .padding()
    }
}
