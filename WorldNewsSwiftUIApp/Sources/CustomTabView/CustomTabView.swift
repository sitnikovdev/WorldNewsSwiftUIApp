//
//  CustomTabView.swift
//  CustomTabView
//
//  Created by Oleg Sitnikov on 05.02.25.
//

import SwiftUI

// TAB
enum Tab: Hashable {
    case main
    case second
}

// MARK: TAB BAR
// MAIN TAB DESTINATION
enum MainTabDestination: Hashable {
    case detail(String)
    case settings
    case profile
}

// SECOND TAB DESTINATION
enum SecondTabDestination: Hashable {
    case detail(String)
}



// MAIN TAB ITEM
struct MainTab: View {

    @StateObject private var router = NavigationRouter.shared

    let item: String // Item parameter string (.tabView(let item) )

    var body: some View {

        // Using NavigationStack for native push/pop navigation within the tab
        NavigationStack(path: $router.mainTabPath) {

            ArticleTabView()

        }
    }
} // MAIN TAB ITEM


// SECOND TAB ITEM
struct SecondTab: View {

    var body: some View {

        Text("Second Tab Content")
            .navigationTitle("Second Tab")
    }

} // SECOND TAB ITEM

// MARK: -SCREENS
struct HomeView: View {
    var body: some View {
        Text("Home")
    }
}

struct BookmarkView: View {
    var body: some View {
        Text("Bookmark")
    }
}

// MARK: - CUSTOM TAB VIEW
struct CustomTabView: View {

    // MARK: - PROPERTIES
    @StateObject private var router = NavigationRouter.shared
    let item: String
    @State private var selectedTab: Tab = .main

    // MARK: - BODY
    var body: some View {

        ZStack {
            TabView(selection: $selectedTab) {
                NavigationStack {
                    MainTab(item: "News Item")
                }
                .tag(Tab.main)

                NavigationStack {
                    BookmarkTabView()
                }
                .tag(Tab.second)

            } // TABVIEW
            VStack {
                Spacer()
                TabBar(selectedTab: $selectedTab)
            }
        } // ZSTACK
    } // BODY


} // CUSTOMTABVIEW



// MARK: CUSTOM TAB BAR
private struct TabBar: View {
    @Binding  var selectedTab: Tab

    var body: some View {

        HStack {

            // NEWS ITEM TAB
            Button {
                withAnimation {
                    selectedTab = .main
                }

            } label: {
                VStack {
                    Image(systemName: "newspaper")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 22)
                    if selectedTab == .main {
                        Text("Home")
                            .font(.system(size: 11))
                    }
                } // NEWS ITEM TAB
                .padding(.leading, 32)
                .foregroundStyle(selectedTab == .main ? .primary : .secondary)

                Spacer()

                // BOOKMARK ITEM TAB
                Button {
                    withAnimation {
                        selectedTab = .second
                    }

                } label: {
                    VStack {
                        Image(systemName: "bookmark")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 18)
                        if selectedTab == .second {
                            Text("Bookmarks")
                                .font(.system(size: 11))
                        }
                    }

                } // BOOKMARK ITEM TAB
                .padding(.trailing, 32)
                .foregroundStyle(selectedTab == .second ? .primary : .secondary)

            }

        } // HSTACK
        .padding()
        .frame(height: 72)
        .background {
            // BOTTOM BAR
            RoundedRectangle(cornerRadius: 36)
                .fill(RadialGradient(colors: [.blue, .black],
                                     center: .center,
                                     startRadius: 2, endRadius: 350
                                    ))

        }
        .padding(.horizontal, 32)
    } // BODY

} // TABBAR

#Preview {
    CustomTabView(item: "Home")
}

