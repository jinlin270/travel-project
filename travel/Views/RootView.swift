//
//  RootView.swift
//  travel
//
//  Root of the SwiftUI hierarchy. Observes AuthManager.isAuthenticated and
//  routes the user to either the Welcome/Onboarding flow or the main app.
//
//  Navigation contract:
//    - Not authenticated  →  WelcomeController1 (UIKit welcome screens → Google Sign-In)
//    - Authenticated      →  ExploreRides (main app)
//
//  The view itself contains no logic; all decisions live in AuthManager so
//  a 401 from any API call automatically returns the user to login.
//

import SwiftUI
import UIKit

struct RootView: View {

    // ObservedObject is correct here: AuthManager is a singleton that owns its
    // own lifecycle. @StateObject would imply this view owns it.
    @ObservedObject private var authManager = AuthManager.shared

    // OnboardingViewModel lives here so it survives across the onboarding screens
    // and can be injected into the SwiftUI environment cleanly.
    @StateObject private var onboardingVM = OnboardingViewModel()

    var body: some View {
        if !authManager.isAuthenticated {
            // Not signed in → welcome / Google Sign-In flow
            WelcomeEmbedView()
        } else if authManager.needsOnboarding {
            // Signed in but profile incomplete → onboarding flow.
            // OnboardingController1 already contains its own NavigationStack;
            // wrap only in environmentObject, not another NavigationStack.
            OnboardingController1()
                .environmentObject(onboardingVM)
        } else {
            // Fully authenticated with complete profile → main app
            ExploreRides()
        }
    }
}

// MARK: - WelcomeEmbedView
//
// Bridges the UIKit WelcomeController1 navigation stack into SwiftUI.
// Using UIViewControllerRepresentable keeps the existing UIKit welcome
// screens untouched while allowing SwiftUI to own the root.

private struct WelcomeEmbedView: UIViewControllerRepresentable {

    func makeUIViewController(context: Context) -> UINavigationController {
        let nav = UINavigationController(rootViewController: WelcomeController1())
        nav.isNavigationBarHidden = true
        return nav
    }

    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {}
}

#Preview {
    RootView()
}
