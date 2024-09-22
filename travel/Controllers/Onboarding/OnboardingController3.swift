import SwiftUI

struct OnboardingController3: View {
    
    @State private var NextPage = false
    @State private var PrevPage = false
    
    var body: some View {
        NavigationView {
            VStack {
                Image("progressBar6")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .padding(.top, 16)
                
                Spacer().frame(height: 68)
                
                Image("ride_with_friends")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                
                Spacer().frame(height: 56)
                
                Text("Invite your friends")
                    .font(.system(size: 24, weight: .bold))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
            
                Spacer().frame(height: 8)
                
                Text("Travel together with friends")
                    .font(.system(size: 16))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                    .frame(maxWidth: 338)
                
                Spacer().frame(height: 56)
            
                
                Button(action: {
                    // Handle Google sign-in action
                }) {
                    HStack(spacing: 8) {
                        Image("googleIcon")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .padding(2)
                            .background(Color.white)
                            .cornerRadius(12)
                        
                        Text("SEND GMAIL")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white)
                    }
                    .padding(0)
                    .frame(maxWidth: 370, maxHeight: 48)
                    .background(Color(red: 0.07, green: 0.27, blue: 0.41))
                    .cornerRadius(24)
                }
                
                Spacer().frame(height: 24)
                
                Button(action: {
                    // Handle Text Message action
                }) {
                    HStack(spacing: 8) {
                        Image("messanger_icon")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .padding(2)
                            .background(Color.white)
                            .cornerRadius(12)
                        
                        Text("TEXT MESSAGE")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.black)
                    }
                    .padding(0)
                    .frame(maxWidth: 370, maxHeight: 48)
                    .cornerRadius(24)
                    .overlay(
                            RoundedRectangle(cornerRadius: 24)
                                .stroke(Color.black, lineWidth: 2)
                        )
                }
                
                Spacer()
                
                NavigationButtons(   onBack: {
                    PrevPage = true
                },
                onNext: {
                    NextPage = true
                })
                
            }.background(Color(.systemBackground))
                .navigationBarHidden(true) //for hiding back button in uikit
                .navigationBarBackButtonHidden(true) //for hiding back button in swiftui
                .navigationDestination(isPresented: $NextPage) {
                    OnboardingProfile()
                            }
                .navigationDestination(isPresented: $PrevPage) {
                    OnboardingController2()
                            }
        }
    }
}



struct OnboardingView3_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingController3()
    }
}

