//
//  ContentView.swift
//  WorldNewsSwiftUIApp
//
//  Created by Oleg Sitnikov on 08.01.25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = WorldNewsViewModel()

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
            }
    }
        .padding()
    }
}

#Preview {
    ContentView()
}
