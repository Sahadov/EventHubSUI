//
//  SignUpView.swift
//  EventHubSUI
//
//  Created by Sergey on 10.09.2025.
//

import SwiftUI

struct SignUpView: View {
    
    @State private var userName: String = .init()
    @State private var userEmail: String = .init()
    @State private var password: String = .init()
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        VStack(spacing: 19) {
            
            Spacer(minLength: 30)
           
            EmailTextField(textFieldValue: $userName, textFieldBorderColor: .constant(Color(cgColor: UIColor(red: 0.896, green: 0.873, blue: 0.873, alpha: 1).cgColor )), textFieldPlaceholder: "Full name", icon: TextFieldImage.profile)
            EmailTextField(textFieldValue: $userEmail, textFieldBorderColor: .constant(Color(cgColor: UIColor(red: 0.896, green: 0.873, blue: 0.873, alpha: 1).cgColor )), icon: .email)
            PasswordTextField(textFieldValue: $password, textFieldBorderColor: .constant(Color(cgColor: UIColor(red: 0.896, green: 0.873, blue: 0.873, alpha: 1).cgColor )))
            PasswordTextField(textFieldValue: $password, textFieldBorderColor: .constant(Color(cgColor: UIColor(red: 0.896, green: 0.873, blue: 0.873, alpha: 1).cgColor )), textFieldPlaceholder: " Confirm password")
            CustomSIButton(buttonLableText: "SIGN UP")
                .offset(x: 0, y: 25)
            Text("OR")
                .offset(x: 0, y: 50)
            
            Image("GoogleButton")
             
                .resizable()
                .frame(width: 363, height: 116)
                .offset(x: 0, y: 55)
            //MARK: Добавить кнопку для гугла
            //            CustomSIButton(buttonLableText: "")
            Spacer()
            HStack {
                Text("Already have an account?")
             
                Button(action: {}){
                    
                    Text("Sign in")
                }

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
    SignUpView()
}
