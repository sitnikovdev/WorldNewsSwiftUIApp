//
//  ArticleView.swift
//  WorldNewsSwiftUIApp
//
//  Created by Oleg Sitnikov on 21.01.25.
//

import SwiftUI

struct ArticleView: View {
    // MARK: - PROPERTIES
    let article: Article

    // MARK: - BODY
    var body: some View {
        VStack {
            // MARK: - IMAGE
            AsyncImage(url: article.imageURL) { phase in
                switch phase {

                case .empty:
                    HStack {
                        Spacer()
                        ProgressView()
                            .frame(width: 50, height: 50)
                        Spacer()
                    }

                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)

                case .failure:
                    HStack {
                        Spacer()
                        Image(systemName: "exclamationmark.triangle.fill")
                            .imageScale(.large)
                        Spacer()
                    }
                @unknown default:
                    EmptyView()
                }
            }
            .frame(minHeight: 200, maxHeight: 300)
            .background(Color.gray.opacity(0.3))
            .clipped()

            VStack {
                // MARK: - TITLE
                Text(article.title)
                    .font(.headline)
                    .lineLimit(3)

                // MARK: - DESCRIPTION
                Text(article.description)
                    .font(.subheadline)
                    .lineLimit(2)

                HStack {
                    Text(article.dateCaption)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Spacer()
                }
            }

        }
    }
}
