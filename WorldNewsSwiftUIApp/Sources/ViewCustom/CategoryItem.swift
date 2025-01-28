//
//  CategoryItem.swift
//  CategoryItem
//
//  Created by Oleg Sitnikov on 23.01.25.
//
import SwiftUI

struct CategoryItem: View {
    @Environment(\.colorScheme) var colorScheme
    var item: Category
    var isSelected: Bool = false

    var body: some View {
        VStack {
            Text(item.rawValue.capitalized)
                .font(.footnote
                    .weight(isSelected ? .bold : .medium)
                )
                .foregroundColor(isSelected ? selectedColor : .gray)
                .padding(.horizontal, 4)
                .padding(.top, 4)
                .padding(.bottom, 2)
                .frame(maxWidth: .infinity)
                .background(Color.clear)
                .multilineTextAlignment(.center)
            item.indicatorImage
                .font(.title)
                .symbolRenderingMode(colorScheme == .dark ? .hierarchical : .monochrome)
                .foregroundColor(colorScheme == .dark ? .white : .blue)
                .padding(.bottom, 8)
        }
    }

    var selectedColor: Color {
        colorScheme == .dark ? .white : .black
    }
}
