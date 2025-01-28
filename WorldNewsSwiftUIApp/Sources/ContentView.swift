//
//  ContentView.swift
//  WorldNewsSwiftUIApp
//
//  Created by Oleg Sitnikov on 08.01.25.
//

import SwiftUI
import Foundation

struct ContentView: View {
    var body: some View {
        TabView {
            NewsTabView()
                .tabItem {
                    Label("News", systemImage: "newspaper")
                }
            BookmarkTabView()
                .tabItem {
                    Label("Bookmarks", systemImage: "bookmark.fill")
                }
        }
    }
}

#Preview {
    ContentView()
}
