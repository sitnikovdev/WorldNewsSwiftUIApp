//
//  Untitled.swift
//  WorldNewsSwiftUIApp
//
//  Created by Oleg Sitnikov on 06.02.25.
//
import SwiftUI

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


// ANIMATION
var transitionAnimation: Animation {
    .easeInOut(duration: 0.3)
}

// TRANSITION
// For "back" direction
var rightTransition: AnyTransition {
    .asymmetric(
        insertion: .move(edge: .leading)
                   .combined(with: .opacity),

        removal: .move(edge: .trailing)
                 .combined(with: .opacity)
    )
}

// For "right" direction
var leftTransition: AnyTransition {
     .asymmetric(

        insertion: .move(edge: .trailing)
                   .combined(with: .opacity),

        removal: .move(edge: .leading)
                 .combined(with: .opacity)
    )
}
