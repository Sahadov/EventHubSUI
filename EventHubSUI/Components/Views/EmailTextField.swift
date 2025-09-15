//
//  EmailTextField.swift
//  EventHubSUI
//
//  Created by Sergey on 11.09.2025.
//

import SwiftUI

enum TextFieldImage {
    case profile
    case lock
    case hidden
    case email
    
    var icon: String {
        
        switch self {
        case .profile:
            return "Profile"
        case .lock:
            return "Lock"
        case .hidden:
            return "Hidden"
        case .email:
            return "Message"
        }
    }
}

struct EmailTextField: View {
    
    @Binding var textFieldValue: String
    @Binding var textFieldBorderColor: Color
    
    var textFieldPlaceholder: String = "abc@email.com"
    var textFieldCornerRadius: CGFloat = 12
    var textFieldHeight: CGFloat = 56
    var textFieldWidth: CGFloat = 317
    var textFieldStrokeLineWidth: CGFloat = 1
    var textFieldInternalPadding: CGFloat = 12
    var keyboardType: UIKeyboardType = .emailAddress
    var fillColor: Color = .white
    var icon: TextFieldImage
    
    var body: some View {
        HStack {
            Spacer(minLength: 15)
            Image(icon.icon)
                .resizable()
                .frame(width: 22, height: 22)
            
            TextField(textFieldPlaceholder, text: $textFieldValue)
                .font(.Airbnb.book(size: 14))
                .foregroundColor(Color(red: 0.46, green: 0.46, blue: 0.53))
                .padding(textFieldInternalPadding)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .keyboardType(keyboardType)
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
    EmailTextField(textFieldValue: .constant(""), textFieldBorderColor: .constant(Color(cgColor: UIColor(red: 0.896, green: 0.873, blue: 0.873, alpha: 1).cgColor )), icon: .email )
}
