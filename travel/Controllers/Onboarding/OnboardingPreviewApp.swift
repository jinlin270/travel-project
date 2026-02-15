//
//  OnboardingPreviewApp.swift
//  StuGo - travel
//
//  Preview demo to showcase all onboarding screens
//  Use the previews at the bottom to see the screens
//

import SwiftUI

// NOTE: This is NOT the app entry point, just a preview demo
// DO NOT add @main here - AppDelegate.swift is the entry point

struct OnboardingFlowDemo: View {
    @State private var currentScreen = 0

    var body: some View {
        TabView(selection: $currentScreen) {
            KeyPurposeView()
                .tag(0)
                .tabItem {
                    Label("Purpose", systemImage: "1.circle")
                }

            KeyPurposeDriverLicenseView()
                .tag(1)
                .tabItem {
                    Label("Driver", systemImage: "2.circle")
                }

            ProfilePictureUploadView()
                .tag(2)
                .tabItem {
                    Label("Profile", systemImage: "3.circle")
                }
        }
    }
}

#Preview {
    OnboardingFlowDemo()
}
