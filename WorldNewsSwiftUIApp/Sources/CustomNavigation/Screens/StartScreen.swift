//
//  StartScreen.swift
//  CustomTabView
//
//  Created by Oleg Sitnikov on 06.02.25.
//


import SwiftUI

struct StartScreen: View {
    @StateObject private var router = NavigationRouter.shared
    
    var body: some View {

        VStack(spacing: 20) {

            // CONTINUE
            // Continue button is shown only if some item was previously selected
            if let _ = router.selectedItem {

                Button("Continue") {

                    if let item = router.selectedItem {
                        // Router in action - navigating to tab view with selected item
                        router.navigate(to: .tabView(item: item))
                    }
                }
            }

            // ABOUT
            Button("About") {
                router.navigate(to: .about)
            }
        }
        .buttonStyle(.borderedProminent)
        .padding()
    }
}
