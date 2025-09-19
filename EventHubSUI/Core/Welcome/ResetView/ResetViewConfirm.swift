//
//  ResetViewConfirm.swift
//  EventHubSUI
//
//  Created by Sergey on 14.09.2025.
//

import SwiftUI

struct ResetViewConfirm: View {
    
    @ObservedObject private var resetVM: ResetViewModel
    
    
    @Environment(\.dismiss) var dismiss
    
    
    init(resetVM: ResetViewModel) {
        self.resetVM = resetVM
    }
    
    var body: some View {
        VStack(spacing: 26) {
            PasswordTextField(textFieldValue: $resetVM.password,
                              textFieldBorderColor: .constant(Color.borderColor()))
            
            if resetVM.stringCheck(checkType: .password, string: resetVM.password) == false {
                Text( ValidateInputError.passwordIncorrect.localizedDescription)
                    .foregroundColor(Color.red)
                    .frame(width: 300, height: 7)
                    .offset(x: -70, y: -13)
            }
            
            PasswordTextField(textFieldValue: $resetVM.confirmPassword,
                              textFieldBorderColor: .constant(Color.borderColor()))
            
            if resetVM.stringCheck(checkType: .passwordMatch, string: resetVM.confirmPassword, passwordMatch: resetVM.password) == false {
                Text( ValidateInputError.passwordNotMatch.localizedDescription)
                    .foregroundColor(Color.red)
                    .frame(width: 300, height: 7)
                    .offset(x: -70, y: -13)
            }
            
            CustomSIButton(buttonLableText: "CHANGE\nPASSWORD") {
                resetVM.changePasswordButtonTapped()
            }
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
    ResetViewConfirm(resetVM: ResetViewModel(validator: ValidationManager(), router: Router(), authManager: AuthManager()))
}
