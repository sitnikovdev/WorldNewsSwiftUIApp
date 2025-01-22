//
//  WorldNewsSwiftUIAppApp.swift
//  WorldNewsSwiftUIApp
//
//  Created by Oleg Sitnikov on 08.01.25.
//

import SwiftUI

@main
struct ArticleSwiftUIAppApp: App {
    // MARK: - PROPERTIES
    let dataProvider: ArticleDataProvider = .init()

    // MARK: - BODY
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(dataProvider)
        }
    }
}
