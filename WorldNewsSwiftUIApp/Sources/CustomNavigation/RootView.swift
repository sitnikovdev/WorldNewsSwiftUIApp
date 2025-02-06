//
//  RootView.swift
//  WorldNewsSwiftUIApp
//
//  Created by Oleg Sitnikov on 06.02.25.
//


import SwiftUI

// MARK: APP ENTRY POINT
// ROOTVIEW
// Root view that orchestrates navigation flow in the application
struct RootView: View {
    @StateObject private var router = NavigationRouter.shared
    
    var body: some View {

        NavigationView {

            ZStack {
                switch router.currentScreen {

                case .start:
                    StartScreen()
                        .transition(router.currentTransition)


                case .tabView(let item):
                    CustomTabView(item: item)
                        .transition(router.currentTransition)

                case .about:
                    AboutScreen()
                        .transition(router.currentTransition)
                }
            }
            .animation(transitionAnimation,
                       value: router.currentScreen)
        }

    }
}
