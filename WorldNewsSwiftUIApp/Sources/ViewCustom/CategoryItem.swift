//
//  CategoryItem.swift
//  CategoryItem
//
//  Created by Oleg Sitnikov on 23.01.25.
//
import SwiftUI

struct CategoryItem: View {
    var item: CategoryQuery
    var isSelected: Bool = false
    
    var body: some View {
        VStack {
            Text(item.rawValue.capitalized)
                .font(.footnote
                    .weight(isSelected ? .bold : .medium)
                )
                .foregroundColor(isSelected ? .black : .gray)
                .padding(.horizontal, 8)
                .frame(maxWidth: .infinity)
                .background(Color.clear)
                .multilineTextAlignment(.center)
//            Text(item.indicatorImage)
        }
    }
}
