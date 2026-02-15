//
//  ProgressIndicator.swift
//  StuGo - travel
//
//  Progress dots indicator for onboarding flow
//  Shows current step in multi-step process
//

import SwiftUI

struct ProgressIndicator: View {
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

#Preview {
    VStack(spacing: 30) {
        ProgressIndicator(totalSteps: 7, currentStep: 0)
        ProgressIndicator(totalSteps: 7, currentStep: 3)
        ProgressIndicator(totalSteps: 7, currentStep: 6)
    }
    .padding()
}
