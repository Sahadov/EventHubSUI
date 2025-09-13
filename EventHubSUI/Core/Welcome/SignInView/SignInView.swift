//
//  SignInView.swift
//  EventHubSUI
//
//  Created by Sergey on 10.09.2025.
//

import SwiftUI

struct SignInView: View {
    
    @State private var email: String = .init()
    @State private var password: String = .init()
    @State private var isRemembered: Bool = false
    
    
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
                           textFieldBorderColor:.constant(Color(cgColor: UIColor(red: 0.896, green: 0.873, blue: 0.873, alpha: 1).cgColor )),
                           icon: .email)
        
            PasswordTextField(textFieldValue: password, textFieldBorderColor:.constant(Color(cgColor: UIColor(red: 0.896, green: 0.873, blue: 0.873, alpha: 1).cgColor )),)
            HStack {
                Spacer(minLength: 25)
                Toggle("", isOn: $isRemembered)
                    .toggleStyle(.automatic)
                    .labelsHidden()
                Spacer(minLength: 10)
                Text("Remember Me")
                
                Spacer()
                
                Button(action: {}) {
                    
                    Text("Forgot password?")
                    
                }
                
                Spacer(minLength: 25)
            }
            .padding()
            CustomSIButton(buttonLableText: "SIGN IN")
            Text("OR")
            
            Image("GoogleButton")
                .resizable()
                .frame(width: 363, height: 116)
            
//            CustomSIButton(buttonLableText: "")
            Spacer()
            HStack {
                Text("Don't have an account?")
                Button(action: {}) {
                    Text("Sign up")
                }
                
            }
            
        }
    }
}

#Preview {
    SignInView()
}
