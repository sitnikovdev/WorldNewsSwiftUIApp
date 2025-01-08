//
//  ContentView.swift
//  WorldNewsSwiftUIApp
//
//  Created by Oleg Sitnikov on 08.01.25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .onAppear {
            Task {
                let greeting = try await WorldNewsClient().getGreeting(name: "World")
                print(greeting)
            }
    }
        .padding()
    }
}

#Preview {
    ContentView()
}
