import SwiftUI
import UIKit

struct OnboardingController1: View {

    @EnvironmentObject private var onboardingVM: OnboardingViewModel

    @State private var gender: String = "Select Gender"
    @State private var NextPage = false
    
    let genders = ["Male", "Female", "Non-binary", "Other"] // Gender options
    
    var body: some View {
        NavigationStack {
            VStack {
                // Progress Bar
                Image("progressBar4")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .padding(.top, 16)
                
                // Thank you labe         
                Text("Thank you for signing in Lin!")
                                .font(.system(size: 16))
                                .padding(.top, 24)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 16)
                
                // Question label
                Text("We would love to know more about you")
                    .font(.system(size: 24, weight: .bold))
                    .multilineTextAlignment(.leading)
                    .lineLimit(nil)
                    .padding(.top, 14)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 16)
                
                // Text Fields
                VStack(spacing: 24) {
                    TextField("Name", text: $onboardingVM.name)
                        .textFieldStyle(CustomTextFieldStyle())

                    TextField("School", text: $onboardingVM.school)
                        .textFieldStyle(CustomTextFieldStyle())
                    
                    // Gender Drop-down (Picker)
                    Menu {
                        ForEach(genders, id: \.self) { genderOption in
                            Button(action: {
                                gender = genderOption // Set the selected gender
                            }) {
                                Text(genderOption)
                            }
                        }
                    } label: {
                        HStack {
                            Text(gender)
                                .foregroundColor(gender == "Select Gender" ? .gray : .black) // Gray if default, black if selected
                                .padding(.leading, 16)
                            Spacer()
                            Image(systemName: "chevron.down")
                                .foregroundColor(.black)
                                .padding(.trailing, 16)
                        }
                        .frame(height: 56)
                        .background(Color.white)
                        .cornerRadius(4)
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(Constants.blue, lineWidth: 2)
                        )
                    }
                    
                    TextField("Pronouns", text: $onboardingVM.pronouns)
                        .textFieldStyle(CustomTextFieldStyle())

                    TextField("Phone number", text: $onboardingVM.phoneNumber)
                        .textFieldStyle(CustomTextFieldStyle())
                }
                .padding(.top, 56)
                .padding(.horizontal, 16)
                
                Spacer().frame(height: 80)
                NavigationButtons(   onBack: {
                    navigateBackToWelcomeController4()
                },
                onNext: {
                    NextPage = true
                })
            
                
            }
            .background(Color(.systemBackground))
            .navigationBarHidden(true) //for hiding back button in uikit
            .navigationBarBackButtonHidden(true) //for hiding back button in swiftui
            .navigationDestination(isPresented: $NextPage) {
                OnboardingController2()
                        }
        }
    }
    
    
    func navigateBackToWelcomeController4() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootController = windowScene.windows.first?.rootViewController else {
            print("Could not find the root view controller")
            return
        }

        if let navigationController = rootController as? UINavigationController {
            // Directly pop to StudentInfoController2 without the loop
            print("Navigation stack: \(navigationController.viewControllers)")
            if let controller = navigationController.viewControllers.first(where: { $0 is WelcomeController4 }) {
                print("Popping to: \(controller)")
                navigationController.popToViewController(controller, animated: true)
            }
        } else {
            // Fallback to dismissing the current view if not using UINavigationController
            print("Root controller: \(String(describing: rootController))")
            rootController.dismiss(animated: true, completion: nil)
        }
    }
}


// Preview
struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingController1()
            .environmentObject(OnboardingViewModel())
    }
}
