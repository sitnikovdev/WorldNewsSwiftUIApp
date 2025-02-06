//
//  NavigationRouter.swift
//  WorldNewsSwiftUIApp
//
//  Created by Oleg Sitnikov on 06.02.25.
//


import SwiftUI

final class NavigationRouter: ObservableObject {
    // SCREENS
    enum Screen: Equatable {
        case start
        case tabView(item: String)
        case about
    }

    // MARK: ROUTER PROPERTIES
    @Published private(set) var currentScreen: Screen = .start

    @Published var selectedTab: Tab = .main

    @Published private(set) var selectedItem: String? = "News"

    // Navigation stack state for each tab
    @Published var mainTabPath: [MainTabDestination] = []
    @Published var secondTabPath: [SecondTabDestination] = []

    // Current transition to be applied
    @Published private(set) var currentTransition: AnyTransition = leftTransition
    static let shared = NavigationRouter()
    private init() {}


    // MARK: ROUTER MAIN NAVIGAION METHOD
    func navigate(to screen: Screen,
                  with direction: NavigationDirection = .rightDirection
    ) {

        DispatchQueue.main.async {

            self.currentTransition = direction.transition

            withAnimation(transitionAnimation) {

                self.currentScreen = screen

                if case .tabView(let item) = screen {
                    self.selectedItem = item
                }
            }
        }
    }
    // Helper method to clear navigation stack
    func clearMainPath() {
        mainTabPath.removeAll()
    }

}
