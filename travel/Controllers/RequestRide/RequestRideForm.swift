//
//  RequestRideForm.swift
//  travel
//
//  Created by Lin Jin on 1/21/25.
//

import SwiftUI

struct RequestRideForm: View {
    @StateObject private var viewModel = FilterViewModel()
    @Environment(\.dismiss) private var dismiss
    @State private var saveTrip: Bool = false
    @Binding var isRideOffer: Bool
    @Binding var didPost: Bool

    var body: some View {

            
            VStack {//VStack1
                
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(height: 64)
                    .background(Constants.blue)
                    .overlay(
                        HStack {
                            Button(action: {
                                viewModel.resetTextFields()
                            }) {
                                Text("Reset")
                                    .font(.system(size: 18))
                                    .foregroundColor(.white)
                            }
                            Spacer()
                            Text(isRideOffer ? "Request A Ride" : "Offer A Ride")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.white)
                            
                            Spacer()
                            Button(action: {
                                // Exit button action here
                                dismiss()
                            }) {
                                Image("close2")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                            }
                        }
                            .padding(.horizontal)
                    )
                
                Spacer().frame(height: 30)
                
                FilterTextField(viewModel: viewModel, passengerText: isRideOffer ? "# Guests" : "# Seats")
                
                Spacer().frame(height: 30)
                
                Text("Who you want to travel with")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 16)
                
                SwappedRadioButtonView(selection: $viewModel.genderPreference, options: ["All females", "All males", "Any"])
                
                Spacer().frame(height: 30)
                
                Text("Recurring")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 16)

                HStack(spacing: 4) {
                    ForEach(RecurringOption.allCases, id: \.self) { option in
                        let isSelected = viewModel.recurringOption == option
                        Button(action: {
                            viewModel.recurringOption = option
                        }) {
                            Text(option.rawValue)
                                .font(.system(size: 13, weight: isSelected ? .semibold : .regular))
                                .foregroundColor(isSelected ? .white : .black)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 8)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(isSelected ? Constants.blue : Color.clear)
                                )
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(8)
                .background(Color(red: 1, green: 0.88, blue: 0.79).opacity(0.6))
                .cornerRadius(12)
                .padding(.horizontal, 16)
                
                
                Spacer()
                
                HStack {
                    Text("Save for next trips")
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                        .lineLimit(1)
                        .truncationMode(.head)
                    
                    Toggle("", isOn: $saveTrip)
                        .tint(Constants.blue)
                        .padding(.leading, 16) // Set padding on the leading side of the Toggle to create 16px gap
                        .labelsHidden() // Hides the label of the Toggle to avoid extra spacing
                }
                .padding(16)
                .frame(maxWidth: .infinity, alignment: .center)
                
                
                if let errorMsg = viewModel.postError {
                    Text(errorMsg)
                        .font(.system(size: 13))
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 16)
                }

                Button(action: {
                    Task {
                        await viewModel.postRideRequest()
                        if viewModel.postSuccess {
                            didPost = true
                            dismiss()
                        }
                    }
                }) {
                    HStack(alignment: .center, spacing: 8) {
                        if viewModel.isPosting {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                .scaleEffect(0.8)
                        }
                        Text(viewModel.isPosting ? "Posting…" : "Post Request")
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .bold))
                    }
                    .padding(16)
                    .frame(width: 361, height: 48, alignment: .center)
                    .background(Constants.blue)
                    .cornerRadius(12)
                    .shadow(color: .black.opacity(0.3), radius: 4.5, x: 0, y: 0)
                    .shadow(color: .black.opacity(0.2), radius: 2.5, x: 0, y: 2)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .inset(by: 0.75)
                            .stroke(Color.black, lineWidth: 1.5)
                    )
                }
                .disabled(viewModel.isPosting)
                
            } .navigationBarHidden(true) //for hiding back button in uikit
                .navigationBarBackButtonHidden(true) //for hiding back button in swiftui
               
    }
}

struct RequestRideForm_Previews: PreviewProvider {
    static var previews: some View {
        @State var falsevar: Bool = false
        @State var didPost: Bool = false
        RequestRideForm(isRideOffer: $falsevar, didPost: $didPost)
    }
}
