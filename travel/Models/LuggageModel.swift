//
//  LuggageModel.swift
//  travel
//
//  Created by Lin Jin on 1/23/25.
//

import SwiftUI

class LuggageModel: ObservableObject {
    @Published var numBags: Int = 0
    @Published var numBagsText: String = ""
    @Published var bagType: String = ""
    @Published var weightText: String = ""
    @Published var weight: Int = 0

    func resetTextFields() {
        numBags = 0
        numBagsText = ""
        bagType = ""
        weightText = ""
        weight = 0
    }
}
