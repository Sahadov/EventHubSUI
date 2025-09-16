//
//  ResetView.swift
//  EventHubSUI
//
//  Created by Sergey on 10.09.2025.
//

import SwiftUI

struct ResetView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var email: String = ""
    
    var body: some View {
        VStack(spacing: 26) {
            Spacer(minLength: 10)
            Text("Please enter your email address to request a password reset")
                .frame(width: 310, alignment: .topLeading)
            EmailTextField(textFieldValue: $email,
                           textFieldBorderColor: .constant(Color.borderColor()),
                           icon: .email)
            Spacer(minLength: 40)
            CustomSIButton(buttonLableText: "SEND") {
                
            }
            
            Spacer(minLength: 350)
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
    ResetView()
}
