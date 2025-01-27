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
                .frame(height: 40)
                .cornerRadius(5)
                .shimmering()
            Rectangle()
                .fill(Color.gray.opacity(0.2))
                .frame(height: 40)
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
