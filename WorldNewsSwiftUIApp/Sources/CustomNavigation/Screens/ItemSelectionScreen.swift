//
//  ItemSelectionScreen.swift
//  CustomTabView
//
//  Created by Oleg Sitnikov on 06.02.25.
//


import SwiftUI

struct ItemSelectionScreen: View {
    @StateObject private var router = NavigationRouter.shared
    
    var body: some View {
        VStack(spacing: 20) {

            // ITEM ONE
            Button("Item One") {
                router.navigate(to: .itemDetails("Item One"))
            }

            // ITEM TWO
            Button("Item Two") {
                router.navigate(to: .itemDetails("Item Two"))
            }
        }
        .buttonStyle(.borderedProminent)
        .navigationTitle("Select Item")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {

                Button("Back") {
                    router.navigate(to: .start,
                                    with: .leftDirection)
                }
            }
        }
    }
}