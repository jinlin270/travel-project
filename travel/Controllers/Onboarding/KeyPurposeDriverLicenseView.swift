//
//  KeyPurposeDriverLicenseView.swift
//  StuGo - travel
//
//  Feature: Driver Purpose + License Upload
//
//  Combined onboarding screen showing:
//  - Purpose selection (with "offer rides" pre-selected)
//  - Driver license upload section
//
//  This screen appears when user selects "I would love to offer rides"
//
//  Dependencies:
//  - Views/RadioButtons/SimpleRadioButton.swift
//  - Views/NavigationButtons.swift
//  - Views/ProgressIndicator.swift
//  - Models/Constants.swift
//
//  Navigation:
//  - Back: KeyPurposeView
//  - Next: ProfilePictureUploadView
//

import SwiftUI

struct KeyPurposeDriverLicenseView: View {
    @State private var selectedPurpose: UserPurpose = .offerRides
    @State private var selectedDocument: UIImage? = nil
    @State private var isDocumentPickerPresented = false
    @State private var NavBack = false
    @State private var NavNext = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    // Title
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

                    Spacer().frame(height: 50)

                    // Driver License Upload Section
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Upload Driver License")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.black)
                            .padding(.horizontal, 24)

                        // Upload box
                        ZStack {
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(height: 180)
                                .background(Color.white)
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .inset(by: 0.5)
                                        .stroke(Color.gray, style: StrokeStyle(lineWidth: 1, dash: [5, 5]))
                                )

                            VStack(spacing: 12) {
                                if let document = selectedDocument {
                                    Image(uiImage: document)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 60, height: 60)
                                        .cornerRadius(4)
                                } else {
                                    Image(systemName: "icloud.and.arrow.up")
                                        .font(.system(size: 40))
                                        .foregroundColor(.gray)
                                }

                                Text("Browse")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(.black)

                                Text("Supported formats: JPEG, PNG, PDF and JPG")
                                    .font(.system(size: 12))
                                    .foregroundColor(.gray)
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 20)
                            }
                        }
                        .padding(.horizontal, 24)
                        .onTapGesture {
                            isDocumentPickerPresented = true
                        }

                        // Upload button
                        Button(action: {
                            // Handle upload
                            print("Upload driver license")
                        }) {
                            Text("UPLOAD")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(width: 140, height: 50)
                                .background(Constants.blue)
                                .cornerRadius(25)
                        }
                        .frame(maxWidth: .infinity)
                    }

                    Spacer().frame(height: 60)
                }
            }
            .background(Color.white)

            VStack(spacing: 0) {
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
            .sheet(isPresented: $isDocumentPickerPresented) {
                ImagePicker(selectedImage: $selectedDocument)
            }
            .navigationDestination(isPresented: $NavNext) {
                ProfilePictureUploadView()
            }
        }
    }
}

#Preview("Default State") {
    KeyPurposeDriverLicenseView()
}

#Preview("With Document") {
    KeyPurposeDriverLicenseView()
}
