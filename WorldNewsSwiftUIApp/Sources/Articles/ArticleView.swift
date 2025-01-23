//
//  ArticleView.swift
//  WorldNewsSwiftUIApp
//
//  Created by Oleg Sitnikov on 21.01.25.
//

import SwiftUI

struct ArticleView: View {
    let item: ArticleItem
    // MARK: - PROPERTIES

    // MARK: - BODY
    var body: some View {
        VStack {
            Spacer()
            Text(item.article.title ?? "No title")
                .font(.title)
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

                    case .failure:
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
