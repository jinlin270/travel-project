//
//  ProfilePictureUploadView.swift
//  StuGo - travel
//
//  Feature: Profile Picture Upload
//
//  Onboarding screen for uploading profile picture
//  Features:
//  - Large circular placeholder for profile image
//  - Browse button to select image
//  - Upload button to confirm
//  - Shows selected image preview
//
//  Dependencies:
//  - Views/NavigationButtons.swift
//  - Views/ProgressIndicator.swift
//  - Models/Constants.swift
//
//  Navigation:
//  - Back: KeyPurposeView
//  - Next: Next onboarding step
//

import SwiftUI
import PhotosUI

struct ProfilePictureUploadView: View {
    @State private var selectedImage: UIImage? = nil
    @State private var isImagePickerPresented = false
    @State private var NavBack = false
    @State private var NavNext = false

    var body: some View {
        NavigationStack {
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
                        // Handle upload
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
                NavigationButtons(
                    onBack: {
                        NavBack = true
                    },
                    onNext: {
                        NavNext = true
                    }
                )

                // Progress indicator
                ProgressIndicator(totalSteps: 7, currentStep: 6)
                    .padding(.bottom, 40)
            }
            .background(Color.white)
            .navigationBarBackButtonHidden(true)
            .sheet(isPresented: $isImagePickerPresented) {
                ImagePicker(selectedImage: $selectedImage)
            }
        }
    }
}

// Image Picker wrapper for SwiftUI
struct ImagePicker: UIViewControllerRepresentable {
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
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
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

#Preview("Default State") {
    ProfilePictureUploadView()
}

#Preview("With Image") {
    ProfilePictureUploadView()
}
