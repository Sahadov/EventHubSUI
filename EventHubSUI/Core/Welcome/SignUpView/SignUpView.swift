//
//  SignUpView.swift
//  EventHubSUI
//
//  Created by Sergey on 10.09.2025.
//

import SwiftUI

struct SignUpView: View {
    
    @ObservedObject private var signUpVM: SignUpViewModel
    
    
    @Environment(\.dismiss) var dismiss
    
    init(signUpVM: SignUpViewModel) {
        self.signUpVM = signUpVM
    }
    
    var body: some View {
        
        VStack(spacing: 19) {
            
            Spacer(minLength: 30)
            
            EmailTextField(textFieldValue: $signUpVM.userName,
                           textFieldBorderColor: .constant(Color.borderColor()),
                           textFieldPlaceholder: "Full name",
                           icon: TextFieldImage.profile)
            
            if signUpVM.stringCheck(checkType: .userName, string: signUpVM.userName) == false {
                Text( ValidateInputError.userNameError.localizedDescription)
                    .foregroundColor(Color.red)
                    .frame(width: 300, height: 7)
                    .offset(x: -70, y: -13)
            }
            
            EmailTextField(textFieldValue: $signUpVM.userEmail,
                           textFieldBorderColor: .constant(Color.borderColor()),
                           icon: .email)
            
            if signUpVM.stringCheck(checkType: .email, string: signUpVM.userEmail) == false {
                Text( ValidateInputError.wrongSymbolsEmail.localizedDescription)
                    .foregroundColor(Color.red)
                    .frame(width: 300, height: 7)
                    .offset(x: -70, y: -13)
            }
            PasswordTextField(textFieldValue: $signUpVM.password,
                              textFieldBorderColor: .constant(Color.borderColor()))
            
            if signUpVM.stringCheck(checkType: .password, string: signUpVM.password) == false {
                Text( ValidateInputError.passwordIncorrect.localizedDescription)
                    .foregroundColor(Color.red)
                    .frame(width: 300, height: 7)
                    .offset(x: -70, y: -13)
            }
            PasswordTextField(textFieldValue: $signUpVM.passwordConfirmation,
                              textFieldBorderColor: .constant(Color.borderColor()),
                              textFieldPlaceholder: " Confirm password")
            
            if signUpVM.stringCheck(checkType: .passwordMatch, string: signUpVM.passwordConfirmation, passwordMatch: signUpVM.password) == false {
                Text( ValidateInputError.passwordNotMatch.localizedDescription)
                    .foregroundColor(Color.red)
                    .frame(width: 300, height: 7)
                    .offset(x: -70, y: -13)
            }
            
            CustomSIButton(buttonLableText: "SIGN UP") {
                
                signUpVM.signUpButtonPressed()
                
            }
                .offset(x: 0, y: 25)
            Text("OR")
                .offset(x: 0, y: 50)
            
            
            //MARK: Добавить кнопку для гугла
            //            CustomSIButton(buttonLableText: "")
            Spacer()
            Button(action: {
                self.signUpVM.signInWithGoogleTapped()
            }) {
                
                Image("GoogleButton")
                    .resizable()
                    .frame(width: 363, height: 116)
                
            }
            Spacer()
            HStack {
                Text("Already have an account?")
                
                Button(action: {
                    
                    dismiss()
                    
                }){
                    
                    Text("Sign in")
                }
                
            }
            .alert(signUpVM.errorTitle, isPresented: $signUpVM.showError) {} message: {
                Text(signUpVM.errorMessage)
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
                Text("                Sign up")
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
    SignUpView(signUpVM: SignUpViewModel(authManager: AuthManager(), validator: ValidationManager(), router: Router()))
}
