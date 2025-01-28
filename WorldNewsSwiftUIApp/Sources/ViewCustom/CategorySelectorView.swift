//
//  NewsCategorySelectorView.swift
//  WorldNewsSwiftUIApp
//
//  Created by Oleg Sitnikov on 24.01.25.
//

import SwiftUI

struct CategorySelectorView: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var selectedItem: Category
    let selectedCategory = SelectedCategory.items

    var body: some View {

        CategorySelector(
            selectedCategory,
            selection: selectedItem,
            indicatorBuilder: {
                GeometryReader { geo in
                    Rectangle()
                        .foregroundColor(colorScheme == .dark ? .pink : .white)
                        .cornerRadius(6.0)
                        .padding(1)
                        .frame(width: geo.size.width / CGFloat(selectedCategory.count))
                        .shadow(color: .black.opacity(0.1), radius: 2, x: 1, y: 1)
                        .animation(.spring().speed(1.5))
                        .offset(x: geo.size.width / CGFloat(selectedCategory.count) * CGFloat(selectedCategory.firstIndex(of: selectedItem)!), y: 0)
                }.frame(height: 90)
            }
        ) { item in
            CategoryItem(
                item: item,
                isSelected: selectedItem == item
            )
            .padding(.vertical, 8)

            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.150)) {
                    selectedItem = item
                }
            }
        }
    }
}
