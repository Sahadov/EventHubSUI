//
//  PasswordTextField.swift
//  EventHubSUI
//
//  Created by Sergey on 13.09.2025.
//

import SwiftUI

struct PasswordTextField: View {
    
    @State var textFieldValue: String = ""
    @Binding var textFieldBorderColor: Color
    
    @State private var password: String = ""
    
    @State private var showPassword: Bool = false
    
    var textFieldPlaceholder: String = "Your password"
    var textFieldCornerRadius: CGFloat = 12
    var textFieldHeight: CGFloat = 56
    var textFieldWidth: CGFloat = 317
    var textFieldStrokeLineWidth: CGFloat = 1
    var textFieldInternalPadding: CGFloat = 12
    var keyboardType: UIKeyboardType = .emailAddress
    var fillColor: Color = .white
    var icon: TextFieldImage = TextFieldImage.lock
    
    
    var body: some View {
        HStack {
            Spacer(minLength: 15)
            Image(icon.icon)
                .resizable()
                .frame(width: 22, height: 22)
            
            if showPassword {
                TextField(textFieldPlaceholder, text: $textFieldValue)
                    .font(.Airbnb.book(size: 14))
                    .foregroundColor(Color(red: 0.46, green: 0.46, blue: 0.53))
                    .padding(textFieldInternalPadding)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .keyboardType(keyboardType)
            } else {
                
                SecureField(textFieldPlaceholder, text: $textFieldValue)
                    .font(.Airbnb.book(size: 14))
                    .foregroundColor(Color(red: 0.46, green: 0.46, blue: 0.53))
                    .padding(textFieldInternalPadding)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .keyboardType(keyboardType)
            }
            
            Button(action: {self.showPassword.toggle()}) {
                
                Image("Hidden")
                    .resizable()
                    .frame(width: 22, height: 22)
                
            }
            
            Spacer(minLength: 10)
        }
        .frame(width: textFieldWidth, height: textFieldHeight)
        .background {
            RoundedRectangle(cornerRadius: textFieldCornerRadius)
                .fill(fillColor)
                .overlay {
                    RoundedRectangle(cornerRadius: textFieldCornerRadius)
                        .stroke(textFieldBorderColor, lineWidth: textFieldStrokeLineWidth)
                }
        }
    }
}

#Preview {
    PasswordTextField(textFieldBorderColor: .constant(Color(cgColor: UIColor(red: 0.896, green: 0.873, blue: 0.873, alpha: 1).cgColor )))
}
