//
//  WorldNewsSwiftUIAppApp.swift
//  WorldNewsSwiftUIApp
//
//  Created by Oleg Sitnikov on 08.01.25.
//

import SwiftUI

@main
struct ArticleSwiftUIAppApp: App {
    @StateObject var articleVM = ArticleViewModel.shared
    // MARK: - PROPERTIES

    // MARK: - BODY
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(articleVM)
        }
    }
}
