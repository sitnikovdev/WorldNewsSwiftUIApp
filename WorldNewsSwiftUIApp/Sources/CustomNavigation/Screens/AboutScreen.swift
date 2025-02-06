//
//  AboutScreen.swift
//  CustomTabView
//
//  Created by Oleg Sitnikov on 06.02.25.
//


import SwiftUI

struct AboutScreen: View {
    @StateObject private var router = NavigationRouter.shared

    var body: some View {
        VStack {
            Text("About Screen")
                .font(.title)
        }
        .navigationTitle("About")
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