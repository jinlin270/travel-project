//
//  DateTextField.swift
//  travel
//
//  Created by Lin Jin on 1/21/25.
//

import SwiftUI

struct DateTextField: View {
    @State private var dateString: String = ""
    @State private var date: Date = Date()

    var body: some View {
        VStack {
            TextField("MM/DD/YYYY", text: $dateString)
                .textFieldStyle(CustomTextFieldStyle())
                .onChange(of: dateString) { newValue in
                    let formattedDate = formatDate(newValue)
                    if let date = formattedDate {
                        self.date = date
                        self.dateString = formatDateToString(date)
                    }
                    
                    print("\(date)")
                }
        }
        .padding()
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
//
//struct CustomTextFieldStyle: TextFieldStyle {
//    func body(content: Content) -> some View {
//        content
//            .padding()
//            .background(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 2))
//            .padding()
//    }
//}

struct DateTextField_Previews: PreviewProvider {
    static var previews: some View {
        DateTextField()
    }
}
