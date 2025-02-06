import SwiftUI

// MARK: NAVIGATION

// NAVIGATION TRANSITION
enum NavigationDirection {
    case leftDirection  // For "back" navigation
    case rightDirection // For "forward" navigation

    // Smooth transitions between screens
    var transition: AnyTransition {

        switch self {

        case .leftDirection:
             rightTransition
        case .rightDirection:
             leftTransition
        }
    }
} // NAVIGATION DIRECTION

// NAVIGATION ROUTER
final class NavigationRouter: ObservableObject {
    // SCREENS
    enum Screen: Equatable {
        case start
        case itemSelection
        case itemDetails(String)
        case tabView(item: String)
        case about
    }

    // MARK: ROUTER PROPERTIES
    @Published private(set) var currentScreen: Screen = .start

    @Published var selectedTab: Tab = .main

    @Published private(set) var selectedItem: String? = nil

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

} // NAVIGATIONROUTER


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

                case .itemSelection:
                    ItemSelectionScreen()
                        .transition(router.currentTransition)

                case .itemDetails(let item):
                    DetailsScreen(item: item)
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
} // ROOTVIEW


// ANIMATION
private var transitionAnimation: Animation {
    .easeInOut(duration: 0.3)
}

// TRANSITION
// For "back" direction
private var rightTransition: AnyTransition {
    .asymmetric(
        insertion: .move(edge: .leading)
                   .combined(with: .opacity),

        removal: .move(edge: .trailing)
                 .combined(with: .opacity)
    )
}

// For "right" direction
private var leftTransition: AnyTransition {
     .asymmetric(

        insertion: .move(edge: .trailing)
                   .combined(with: .opacity),

        removal: .move(edge: .leading)
                 .combined(with: .opacity)
    )
}
