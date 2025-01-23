//
//  ArticleView.swift
//  WorldNewsSwiftUIApp
//
//  Created by Oleg Sitnikov on 21.01.25.
//

import SwiftUI

struct ArticleView: View {
    let article: Article
    // MARK: - PROPERTIES

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



            Spacer()
            Spacer()
            Text("\(article.publishedAt ?? .now)")
            Spacer()
            Spacer()
            Divider()
        }
    }
}
