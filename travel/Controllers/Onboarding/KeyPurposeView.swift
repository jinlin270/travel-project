//
//  KeyPurposeView.swift
//  StuGo - travel
//
//  Feature: User Purpose Selection
//
//  Onboarding screen where users select their primary purpose:
//  - Offer rides (driver)
//  - Find/request rides (passenger)
//  - Explore community
//
//  Dependencies:
//  - Views/RadioButtons/SimpleRadioButton.swift
//  - Views/NavigationButtons.swift
//  - Views/ProgressIndicator.swift
//  - Models/Constants.swift
//
//  Navigation:
//  - Back: Previous onboarding screen
//  - Next: ProfilePictureUploadView or DriverLicenseUploadView (if offering rides)
//

import SwiftUI

enum UserPurpose: Int, CaseIterable {
    case offerRides = 0
    case requestRides = 1
    case exploreCommunity = 2

    var displayText: String {
        switch self {
        case .offerRides:
            return "I would love to offer rides"
        case .requestRides:
            return "I want to find or request rides"
        case .exploreCommunity:
            return "I want to explore the traveling community first"
        }
    }
}

struct KeyPurposeView: View {
    @State private var selectedPurpose: UserPurpose? = nil
    @State private var NavBack = false
    @State private var NavNext = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Title
                VStack(alignment: .leading, spacing: 0) {
                    Text("Your key purpose for being here?")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.black)
                        .padding(.horizontal, 24)
                        .padding(.top, 40)

                    Spacer().frame(height: 40)

                    // Radio options
                    VStack(spacing: 24) {
                        ForEach(UserPurpose.allCases, id: \.self) { purpose in
                            SimpleRadioButton(
                                isSelected: Binding(
                                    get: { selectedPurpose == purpose },
                                    set: { isSelected in
                                        if isSelected {
                                            selectedPurpose = purpose
                                        }
                                    }
                                ),
                                text: purpose.displayText
                            )
                            .padding(.horizontal, 24)
                        }
                    }
                }

                Spacer()

                // Navigation buttons
                NavigationButtons(
                    onBack: {
                        NavBack = true
                    },
                    onNext: {
                        NavNext = true
                    }
                )

                // Progress indicator
                ProgressIndicator(totalSteps: 7, currentStep: 5)
                    .padding(.bottom, 40)
            }
            .background(Color.white)
            .navigationBarBackButtonHidden(true)
            .navigationDestination(isPresented: $NavNext) {
                if selectedPurpose == .offerRides {
                    KeyPurposeDriverLicenseView()
                } else {
                    ProfilePictureUploadView()
                }
            }
        }
    }
}

#Preview("Default State") {
    KeyPurposeView()
}

#Preview("With Selection") {
    KeyPurposeView()
}
