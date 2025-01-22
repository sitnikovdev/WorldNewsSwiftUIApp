//
//  ArticleListView.swift
//  WorldNewsSwiftUIApp
//
//  Created by Oleg Sitnikov on 21.01.25.
//

import SwiftUI

struct ArticleListView: View {
    // MARK: PROPERTIES
    @Environment(ArticleDataProvider.self) var dataProvider

    // MARK: - BODY
    var body: some View {
        NavigationStack {
            Form {
                List(dataProvider.articleItems, id: \.id) { item in

                           VStack {
                               Text(item.article.author ?? "No author")
                               Spacer()
                               Text(item.article.title ?? "No title")
                               Spacer()
                               Text(item.article.toImageUrl ?? "No image")
                               Spacer()
                               Spacer()
                               Spacer()
                               Divider()
                           }
               }
            }
            .navigationTitle("Total News: \(dataProvider.articleItems.count)")
        }
    }
}

// MARK: - PREVIEW
#Preview(traits: .mockData) {
    ArticleListView()
}
