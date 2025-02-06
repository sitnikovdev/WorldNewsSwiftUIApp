//
//  DetailsScreen.swift
//  CustomTabView
//
//  Created by Oleg Sitnikov on 06.02.25.
//


import SwiftUI

struct DetailsScreen: View {
    @StateObject private var router = NavigationRouter.shared
    let item: String
    
    var body: some View {
        VStack(spacing: 20) {

            // DETAILS
            Text("Details for \(item)")
                .font(.title)

            // CONTINUE
            Button("Continue") {
                router.navigate(to: .tabView(item: item))
            }
        }
        .buttonStyle(.borderedProminent)
        .navigationTitle("Details")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {

                // BACK BUTTON
                Button("Back") {
                    router.navigate(to: .itemSelection,
                                    with: .leftDirection)
                }
            }
        }
    }
}