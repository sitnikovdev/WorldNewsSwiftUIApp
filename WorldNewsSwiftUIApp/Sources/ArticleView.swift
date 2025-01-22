//
//  ArticleView.swift
//  WorldNewsSwiftUIApp
//
//  Created by Oleg Sitnikov on 21.01.25.
//

import SwiftUI

struct ArticleView: View {
    // MARK: - PROPERTIES
    let viewModel: ArticleDataProvider = .init()

    // MARK: - BODY
    var body: some View {
        Text("ArticleView")
    }
}

// MARK: - PREVIEW
#Preview {
    ArticleView()
}
