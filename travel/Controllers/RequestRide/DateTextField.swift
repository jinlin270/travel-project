//
//  DateTextField.swift
//  travel
//
//  Created by Lin Jin on 1/21/25.
//

import SwiftUI

struct DateTextField: View {
    @ObservedObject var viewModel: FilterViewModel

    var body: some View {
        VStack {
            TextField("MM/DD/YYYY", text: $viewModel.dateString)
                .textFieldStyle(CustomTextFieldStyle())
                .onChange(of: viewModel.dateString) { newValue in
                    let formattedDate = formatDate(newValue)
                    if let date = formattedDate {
                        viewModel.date = date
                        viewModel.dateString = formatDateToString(date)
                    }
                    
                }
        }
       
    }

    private func formatDate(_ input: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.date(from: input)
    }

    private func formatDateToString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.string(from: date)
    }
}


struct DateTextField_Previews: PreviewProvider {
    static var previews: some View {
        DateTextField(viewModel: FilterViewModel())
    }
}
