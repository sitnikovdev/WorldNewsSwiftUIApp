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
        List(dataProvider.articleItems, id: \.id) { item in

            VStack {
                Text(item.article.author ?? "No author")
                Text(item.article.title ?? "No title")
            }
        }
        .onAppear{
//            dataProvider.setMockData()
        }
    }
}

// MARK: - PREVIEW
#Preview(traits: .mockData) {
     ArticleListView()
}
