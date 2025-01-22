//
//  MockDataTrait.swift
//  WorldNewsSwiftUIApp
//
//  Created by Oleg Sitnikov on 22.01.25.
//

import SwiftUI

struct MockDataTrait: PreviewModifier {
    func body(content: Content, context: Void) -> some View {
        @Previewable @State var dataProvider: ArticleDataProvider = .init()
        dataProvider.setMockData()
        return content
            .environment(dataProvider)
    }
}

extension PreviewTrait where T == Preview.ViewTraits {
    static let mockData: Self = .modifier(MockDataTrait())
}


