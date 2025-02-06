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

            Spacer()
            Button {

                if let item = router.selectedItem {
                    // Router in action - navigating to tab view with selected item
                    router.navigate(to: .tabView(item: item))
                }
            } label: {
                Text("Continue")
                    .font(.system(size: 32))
            }
            .padding()

            // ABOUT
            Button {
                router.navigate(to: .about)
            } label: {
                Text("About")
                    .font(.system(size: 24))
            }
            Spacer()
        }
        .buttonStyle(.borderedProminent)
        .padding()
    }
}

#Preview {
    StartScreen()
}
