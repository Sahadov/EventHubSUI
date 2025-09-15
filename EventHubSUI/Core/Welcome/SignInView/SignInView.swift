//
//  SignInView.swift
//  EventHubSUI
//
//  Created by Sergey on 10.09.2025.
//

import SwiftUI

struct SignInView: View {
    
    @ObservedObject var signInVM: SignInViewModel
    
    @State private var email: String = .init()
    @State private var password: String = .init()
    @State private var isRemembered: Bool = false
    @State private var isSignedIn: Bool = false
    
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
                EmailTextField(textFieldValue: $email,
                               textFieldBorderColor:.constant(Color.borderColor()),
                               icon: .email)
                
                PasswordTextField(textFieldValue: password, textFieldBorderColor:.constant(Color.borderColor()))
                HStack {
                    Spacer(minLength: 25)
                    Toggle("", isOn: $isRemembered)
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
                    signInVM.goToMainView()
                }
                Text("OR")
                
                Image("GoogleButton")
                    .resizable()
                    .frame(width: 363, height: 116)
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
                
            }
    }
}

#Preview {
    SignInView(signInVM: SignInViewModel(router: Router()))
}
