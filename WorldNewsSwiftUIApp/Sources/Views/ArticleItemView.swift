//
//  ArticleView.swift
//  WorldNewsSwiftUIApp
//
//  Created by Oleg Sitnikov on 21.01.25.
//

import SwiftUI

struct ArticleItemView: View {
    @EnvironmentObject var articleVM: ArticleViewModel
    // MARK: - PROPERTIES
    let article: Article

    // MARK: - BODY
    var body: some View {
        VStack() {
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
            .frame(minWidth: 300, maxWidth: 350)
            .background(Color.gray.opacity(0.3))
            .clipped()

            VStack() {
                // MARK: - TITLE
                Text(article.titleText)
                    .font(.headline)
                    .lineLimit(3)

                // MARK: - DESCRIPTION
                Text(article.descriptionText)
                    .font(.subheadline)
                    .lineLimit(2)

                // MARK: - DATE
                HStack {
                    Text(article.dateCaption)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Spacer()
                    Button {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            toggleBookmark(for: article)
                        }
                    } label: {
                        Image(systemName: articleVM.isBookmarked(for: article) ? "bookmark.fill" : "bookmark")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(articleVM.isBookmarked(for: article) ? .yellow : .gray)
                            .scaleEffect(articleVM.isBookmarked(for: article) ? 1.3 : 1.0)
                    }
                    .buttonStyle(.bordered)

                }
            }
            .padding([.horizontal, .bottom])
        }

    }
    private func toggleBookmark(for article: Article) {
        // TODO: - Animation of ListView Cell with effect: Fly Away by Curve Down.
        articleVM.bookmark(for: article)
    }
}
