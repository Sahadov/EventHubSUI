//
//  SignInView.swift
//  EventHubSUI
//
//  Created by Sergey on 10.09.2025.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift


struct SignInView: View {
    
    @ObservedObject var signInVM: SignInViewModel
    
    
    init(signInVM: SignInViewModel) {
        self.signInVM = signInVM
    }
    
    var body: some View {
        
        
            
            VStack(spacing: 19) {
                Spacer()
                Image("Logo")
                    .resizable()
                    .frame(width: 55.55, height: 58.18)
                    .offset(x: -80, y: 0)
                Text("EventHub")
                    .font(
                        Font.custom("SF Pro", size: 35)
                            .weight(.bold)
                    )
                    .multilineTextAlignment(.leading)
                    .foregroundColor(Color(red: 0.22, green: 0.21, blue: 0.29))
                    .offset(x: -70, y: -10)
                Text("Sign in")
                    .font(
                        Font.custom("SF Pro", size: 24)
                            .weight(.medium)
                    )
                    .foregroundColor(Color(red: 0.07, green: 0.05, blue: 0.15))
                    .offset(x: -120, y: -10)
                EmailTextField(textFieldValue: $signInVM.email,
                               textFieldBorderColor:.constant(Color.borderColor()),
                               icon: .email)
                
                if signInVM.stringCheck(checkType: .email, string: signInVM.email) == false {
                    Text( ValidateInputError.wrongSymbolsEmail.localizedDescription)
                        .foregroundColor(Color.red)
                        .frame(width: 300, height: 7)
                        .offset(x: -70, y: -13)
                }
                
                PasswordTextField(textFieldValue: $signInVM.password, textFieldBorderColor:.constant(Color.borderColor()))
                
                if signInVM.stringCheck(checkType: .password, string: signInVM.password) == false {
                    Text(ValidateInputError.passwordIncorrect.localizedDescription)
                        .foregroundColor(Color.red)
                        .frame(width: 300, height: 7)
                        .offset(x: -70, y: -13)
                }
                
                   
                    
                HStack {
                    
                    Spacer(minLength: 25)
                    Toggle("", isOn: $signInVM.isRemembered)
                        .toggleStyle(.automatic)
                        .labelsHidden()
                    Spacer(minLength: 10)
                    Text("Remember Me")
                    
                    Spacer()
                    
                    Button(action: {
                        self.signInVM.goToForgotPasswordView()
                    }) {
                        Text("Forgot password?")
                    }
                    
                    Spacer(minLength: 25)
                }
                .padding()
                CustomSIButton(buttonLableText: "SIGN IN") {
                    signInVM.signInButtonTapped()
                }
//                .disabled(signInVM.isWrong)
                Text("OR")
                
                Button(action: {
                    self.signInVM.signInWithGoogleTapped()
                }) {
                    
                    Image("GoogleButton")
                        .resizable()
                        .frame(width: 363, height: 116)
                    
                }
                
                //MARK: Добавить кнопку для гугла
                //            CustomSIButton(buttonLableText: "")
                Spacer()
                HStack {
                    Text("Don't have an account?")
                    Button(action: {
                        self.signInVM.goToSignUpView()
                    }) {
                        Text("Sign up")
                    }
                    
                }
                .alert(signInVM.errorTitle, isPresented: $signInVM.showError) {} message: {
                    Text(signInVM.errorMessage)
                }
                .navigationBarHidden(true)
                .toolbar(.hidden, for: .navigationBar)
                
            }
    }
}

#Preview {
    SignInView(signInVM: SignInViewModel(authManager: AuthManager(), validator: ValidationManager(), router: Router()))
}
