//
//  CustomTextField.swift
//  measure
//
//  Created by Edward Focer on 14/05/25.
//

import SwiftUI

struct CustomTextField: View {
    var placeholder: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default

    var body: some View {
        TextField(placeholder, text: $text)
            .keyboardType(keyboardType)
            .padding(.horizontal, 10)
            .frame(height: 50)
            .background(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color(red: 203/255, green: 208/255, blue: 213/255), lineWidth: 1) // #CBD0D5
            )
            .cornerRadius(8)
    }
}
