//
//  ArticleDetailView.swift
//  WorldNewsSwiftUIApp
//
//  Created by Oleg Sitnikov on 24.01.25.
//

import SwiftUI

struct ArticleDetailView: View {
   @State var article: ArticleDTO?
    @State var selected: ArticleDTO?
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            // MARK: - IMAGE
            AsyncImage(url: article?.imageURL) { phase in
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
            .frame(minWidth: 300, maxWidth: 350)
            .background(Color.gray.opacity(0.3))
            .clipped()

            VStack(alignment: .center, spacing: 8) {
                // MARK: - TITLE
                Text(article?.title ?? "")
                    .font(.headline)
                    .lineLimit(3)

                // MARK: - DESCRIPTION
                Text(article?.content ?? "")
                    .font(.subheadline)
                    .multilineTextAlignment(.leading)

                // MARK: - DATE
                HStack {
                    Text(article?.dateCaption ?? "")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Spacer()
                }
            }
            .padding([.horizontal, .bottom])
        }
        .onTapGesture {

            selected = article
            print("article tapped: \(article?.title ?? "")")
        }
        .sheet(item: $selected) {
            if let url = $0.articleURL {
                SafariView(url: url )
                    .edgesIgnoringSafeArea(.bottom)
            }
        }
    }
}
