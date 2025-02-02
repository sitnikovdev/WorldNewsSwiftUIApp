//
//  SkeletonLoaderView.swift
//  SkeletonLoader
//
//  Created by Oleg Sitnikov on 23.01.25.
//

import SwiftUI

struct SkeletonLoaderView: View {
    var body: some View {
        VStack {
            Rectangle()
                .fill(Color.gray.opacity(0.2))
                .frame(height: 200)
                .cornerRadius(5)
                .shimmering()
            Rectangle()
                .fill(Color.gray.opacity(0.2))
                .frame(height: 40)
                .cornerRadius(5)
                .shimmering()
        }
        .padding()
    }
}

#Preview {
    SkeletonLoaderView()
}

struct Shimmering: ViewModifier {
    @State private var offset: CGFloat = -1

    func body(content: Content) -> some View {
        content
            .overlay(
                LinearGradient(
                    gradient: Gradient(
                        colors: [
                            Color.gray.opacity(0.3),
                            Color.gray.opacity(0.1),
                            Color.gray.opacity(0.3),
                        ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .mask(content)
                .offset(x: offset)
                .animation(
                    .linear(duration: 1.5)
                    .repeatForever(autoreverses: false), value: offset
                ))
                .onAppear {
                    offset = UIScreen.main.bounds.width - 40
                }
    }
}

extension View {
    public func shimmering() -> some View {
        modifier(Shimmering())
    }
}
