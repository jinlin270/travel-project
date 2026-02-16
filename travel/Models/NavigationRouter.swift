//
//  NavigationRouter.swift
//  travel
//
//  Lightweight coordinator that allows any child view to pop
//  back to the root (ExploreRides).  Passed via .environmentObject().
//

import SwiftUI

class NavigationRouter: ObservableObject {
    @Published var shouldPopToRoot = false

    func popToRoot() {
        shouldPopToRoot = true
    }
}
