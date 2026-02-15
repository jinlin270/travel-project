//
//  OnboardingScreensPreview.swift
//  StuGo - travel
//
//  Complete onboarding screens implementation with all components inline
//  Open this file in Xcode and enable Canvas to see all screens
//

import SwiftUI
import PhotosUI

// MARK: - User Purpose Enum
enum UserPurposeType: Int, CaseIterable {
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

// MARK: - Simple Radio Button Component
struct OnboardingRadioButton: View {
    @Binding var isSelected: Bool
    let text: String

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            // Radio circle
            ZStack {
                Circle()
                    .stroke(Color.black, lineWidth: 2)
                    .frame(width: 24, height: 24)

                if isSelected {
                    Circle()
                        .fill(Color.black)
                        .frame(width: 14, height: 14)
                }
            }

            Text(text)
                .font(.system(size: 16, weight: .regular))
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)

            Spacer()
        }
        .contentShape(Rectangle())
        .onTapGesture {
            isSelected = true
        }
    }
}

// MARK: - Progress Indicator Component
struct OnboardingProgressIndicator: View {
    let totalSteps: Int
    let currentStep: Int

    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<totalSteps, id: \.self) { index in
                Circle()
                    .fill(index == currentStep ? Constants.blue : Color.gray.opacity(0.3))
                    .frame(width: 8, height: 8)
            }
        }
    }
}

// MARK: - Navigation Buttons Component
struct OnboardingNavButtons: View {
    let onBack: () -> Void
    let onNext: () -> Void

    var body: some View {
        HStack(spacing: 20) {
            Button(action: onBack) {
                Text("Back")
                    .frame(width: 100, height: 50)
                    .foregroundColor(Constants.blue)
                    .background(Color.clear)
                    .cornerRadius(24)
                    .overlay(
                        RoundedRectangle(cornerRadius: 24)
                            .stroke(Color.black, lineWidth: 1)
                    )
                    .padding(.leading, 10)
            }

            Spacer()

            Button(action: onNext) {
                Text("Next")
                    .frame(width: 100, height: 50)
                    .foregroundColor(.white)
                    .background(Constants.blue)
                    .cornerRadius(24)
                    .overlay(
                        RoundedRectangle(cornerRadius: 24)
                            .stroke(Constants.blue, lineWidth: 3)
                    )
                    .padding(.trailing, 10)
            }
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 20)
    }
}

// MARK: - Image Picker
struct OnboardingImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Environment(\.dismiss) var dismiss

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .photoLibrary
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: OnboardingImagePicker

        init(_ parent: OnboardingImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            parent.dismiss()
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.dismiss()
        }
    }
}

// MARK: - Screen 1: Key Purpose Selection
struct OnboardingKeyPurposeView: View {
    @State private var selectedPurpose: UserPurposeType? = nil
    @State private var NavNext = false

    var body: some View {
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
                    ForEach(UserPurposeType.allCases, id: \.self) { purpose in
                        OnboardingRadioButton(
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
            OnboardingNavButtons(
                onBack: { print("Back") },
                onNext: { NavNext = true }
            )

            // Progress indicator
            OnboardingProgressIndicator(totalSteps: 7, currentStep: 5)
                .padding(.bottom, 40)
        }
        .background(Color.white)
        .navigationDestination(isPresented: $NavNext) {
            if selectedPurpose == .offerRides {
                OnboardingDriverLicenseView()
            } else {
                OnboardingProfilePictureView()
            }
        }
    }
}

// MARK: - Screen 2: Profile Picture Upload
struct OnboardingProfilePictureView: View {
    @State private var selectedImage: UIImage? = nil
    @State private var isImagePickerPresented = false
    @State private var NavNext = false

    var body: some View {
        VStack(spacing: 0) {
            // Title
            Text("Upload your profile picture")
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(.black)
                .padding(.horizontal, 24)
                .padding(.top, 40)

            Spacer().frame(height: 60)

            // Profile picture upload area
            VStack(spacing: 20) {
                // Dashed border container
                ZStack {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 340, height: 220)
                        .background(Color.white)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .inset(by: 0.5)
                                .stroke(Color.gray, style: StrokeStyle(lineWidth: 1, dash: [5, 5]))
                        )

                    VStack(spacing: 16) {
                        // Profile picture circle
                        if let image = selectedImage {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                        } else {
                            Circle()
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 100, height: 100)
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
                .onTapGesture {
                    isImagePickerPresented = true
                }

                // Upload button
                Button(action: {
                    print("Upload image")
                }) {
                    Text("UPLOAD")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(width: 140, height: 50)
                        .background(Constants.blue)
                        .cornerRadius(25)
                }
            }

            Spacer()

            // Navigation buttons
            OnboardingNavButtons(
                onBack: { print("Back") },
                onNext: { NavNext = true }
            )

            // Progress indicator
            OnboardingProgressIndicator(totalSteps: 7, currentStep: 6)
                .padding(.bottom, 40)
        }
        .background(Color.white)
        .sheet(isPresented: $isImagePickerPresented) {
            OnboardingImagePicker(selectedImage: $selectedImage)
        }
    }
}

// MARK: - Screen 3: Driver License Upload (Combined with Purpose)
struct OnboardingDriverLicenseView: View {
    @State private var selectedPurpose: UserPurposeType = .offerRides
    @State private var selectedDocument: UIImage? = nil
    @State private var isDocumentPickerPresented = false
    @State private var NavNext = false

    var body: some View {
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
                    ForEach(UserPurposeType.allCases, id: \.self) { purpose in
                        OnboardingRadioButton(
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
        .overlay(
            VStack {
                Spacer()

                VStack(spacing: 20) {
                    // Navigation buttons
                    OnboardingNavButtons(
                        onBack: { print("Back") },
                        onNext: { NavNext = true }
                    )

                    // Progress indicator
                    OnboardingProgressIndicator(totalSteps: 7, currentStep: 5)
                        .padding(.bottom, 40)
                }
                .background(Color.white)
            }
        )
        .sheet(isPresented: $isDocumentPickerPresented) {
            OnboardingImagePicker(selectedImage: $selectedDocument)
        }
        .navigationDestination(isPresented: $NavNext) {
            OnboardingProfilePictureView()
        }
    }
}

// MARK: - Tab View Demo (Shows all screens)
struct OnboardingScreensDemo: View {
    @State private var currentTab = 0

    var body: some View {
        TabView(selection: $currentTab) {
            NavigationStack {
                OnboardingKeyPurposeView()
            }
            .tabItem {
                Label("Purpose", systemImage: "1.circle.fill")
            }
            .tag(0)

            NavigationStack {
                OnboardingDriverLicenseView()
            }
            .tabItem {
                Label("Driver", systemImage: "2.circle.fill")
            }
            .tag(1)

            NavigationStack {
                OnboardingProfilePictureView()
            }
            .tabItem {
                Label("Profile", systemImage: "3.circle.fill")
            }
            .tag(2)
        }
    }
}

// MARK: - Previews
#Preview("1. Key Purpose") {
    NavigationStack {
        OnboardingKeyPurposeView()
    }
}

#Preview("2. Profile Picture") {
    NavigationStack {
        OnboardingProfilePictureView()
    }
}

#Preview("3. Driver License") {
    NavigationStack {
        OnboardingDriverLicenseView()
    }
}

#Preview("All Screens (Tab View)") {
    OnboardingScreensDemo()
}
