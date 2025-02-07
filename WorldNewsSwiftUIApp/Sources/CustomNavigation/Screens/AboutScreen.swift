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
            Text("Top headlines")
                .font(.system(size: 32))
                .padding(.top)
            Spacer()
            VStack(alignment: .leading, spacing: 4) {
                Text("Features:")
                    .font(.system(size: 24))
                    .padding(.bottom, 4)
                Text("- Apple Open API framework")
                Text("- Pagination")
                Text("- Custom Navigation")
                Text("- Custom Views: Tab View, Picker View")
                Text("- Animatable bookmarked")
            } .font(.system(size: 20))
            Spacer()
            Text("Version 1.0.2")
            Spacer()
            Button {
                router.navigate(to: .start)
            } label: {
                Text("OK")
            }
            Spacer()
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

#Preview {
    AboutScreen()
}
