//
//  ResetViewConfirm.swift
//  EventHubSUI
//
//  Created by Sergey on 14.09.2025.
//

import SwiftUI

struct ResetViewConfirm: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var password: String = ""
    @State var confirmPassword: String = ""
    
    var body: some View {
        VStack(spacing: 26) {
            PasswordTextField(textFieldValue: password,
                              textFieldBorderColor: .constant(Color.borderColor()))
            PasswordTextField(textFieldValue: confirmPassword,
                              textFieldBorderColor: .constant(Color.borderColor()))
            CustomSIButton(buttonLableText: "CHANGE\nPASSWORD")
        }
        
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    
                   dismiss()
                    
                }) {
                    Image(systemName: "arrow.backward")
                        .foregroundColor(.primary)
                    Text("         Reset password")
                        .foregroundStyle(.black)
                        .font(.system(size: 25, weight: .bold))
                        .multilineTextAlignment(.leading)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)

                }
            }
        }
        
    }
}

#Preview {
    ResetViewConfirm()
}
