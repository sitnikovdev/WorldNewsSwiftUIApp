//
//  NewsCategorySelectorView.swift
//  WorldNewsSwiftUIApp
//
//  Created by Oleg Sitnikov on 24.01.25.
//

import SwiftUI

struct CategorySelectorView: View {
    @Binding var selectedItem: Category

    var body: some View {

        CategorySelector(
            Category.allCases,
            selection: selectedItem,
            indicatorBuilder: {
                GeometryReader { geo in
                    Rectangle()
                        .foregroundColor(.white)
                        .cornerRadius(6.0)
                        .padding(1)
                        .frame(width: geo.size.width / CGFloat(Category.allCases.count))
                        .shadow(color: .black.opacity(0.1), radius: 2, x: 1, y: 1)
                        .animation(.spring().speed(1.5))
                        .offset(x: geo.size.width / CGFloat(Category.allCases.count) * CGFloat(Category.allCases.firstIndex(of: selectedItem)!), y: 0)
                }.frame(height: 64)
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
