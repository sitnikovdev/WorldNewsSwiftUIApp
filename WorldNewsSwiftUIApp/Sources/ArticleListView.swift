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
                                   .font(.headline)
                               Spacer()
                               if let imageUrl = item.article.toImageUrl {
                                   AsyncImage(url: URL(string: imageUrl)) { phase in
                                       switch phase {
                                       case .empty:
                                           ProgressView()
                                               .progressViewStyle(.circular)
                                               .frame(width: 50, height: 50)
                                       case .success(let image):
                                           image
                                               .resizable()
                                               .scaledToFill()
                                               .frame(width: 300, height: 200)
                                               .cornerRadius(10)

                                       case .failure(let error):
                                           Image(systemName: "exclamationmark.triangle.fill")
                                       @unknown default:
                                           EmptyView()
                                       }
                                   }
                               }
                               Spacer()
                               Spacer()
                               Text("\(item.article.publishedAt ?? .now)")
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
