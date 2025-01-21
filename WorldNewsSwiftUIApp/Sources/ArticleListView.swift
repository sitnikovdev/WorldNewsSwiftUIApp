//
//  ArticleListView.swift
//  WorldNewsSwiftUIApp
//
//  Created by Oleg Sitnikov on 21.01.25.
//

import SwiftUI

struct ArticleListView: View {
    // MARK: PROPERTIES
    let viewModel: ArticleViewModel = .init()

    // MARK: - BODY
    var body: some View {
        List(viewModel.articles, id: \.id) { item in
            Text("Hello, World!")
        }
    }
}

// MARK: - PREVIEW
#Preview {
    ArticleListView()
}
