//
//  ResetView.swift
//  EventHubSUI
//
//  Created by Sergey on 10.09.2025.
//

import SwiftUI
import Combine

struct ResetView: View {
    
    @ObservedObject var resetVM: ResetViewModel
    
    @Environment(\.dismiss) var dismiss
    @State var wrongInput: Bool = false
    
    init(resetVM: ResetViewModel) {
        self.resetVM = resetVM
    }
    
    var body: some View {
        VStack(spacing: 26) {
            Spacer(minLength: 10)
            Text("Please enter your email address to request a password reset")
                .frame(width: 310, alignment: .topLeading)
            EmailTextField(textFieldValue: $resetVM.email,
                           textFieldBorderColor: .constant(Color.borderColor()),
                           icon: .email)
            
            if resetVM.stringCheck(checkType: .email, string: resetVM.email) == false {
                Text(ValidateInputError.wrongSymbolsEmail.localizedDescription)
                    .foregroundColor(Color.red)
                    .frame(width: 300, height: 7)
                    .offset(x: -70, y: -13)
            } 
            
            Spacer(minLength: 40)
            CustomSIButton(buttonLableText: "SEND") {
                self.resetVM.resetButtonTapped()
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
    ResetView(resetVM: ResetViewModel(validator: ValidationManager(), router: Router()))
}
