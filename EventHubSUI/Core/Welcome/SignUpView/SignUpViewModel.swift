//
//  SignUpViewModel.swift
//  EventHubSUI
//
//  Created by Sergey on 10.09.2025.
//

import Foundation
import SwiftUI

@MainActor
final class SignUpViewModel: ObservableObject {
    
    @ObservedObject var authManager: AuthManager
    @ObservedObject var validator: ValidationManager
    @ObservedObject var router: Router
    
    @Published var userName: String = ""
    @Published var userEmail: String = ""
    @Published var password: String = ""
    @Published var passwordConfirmation: String = ""
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    @Published var errorTitle: String = ""
    
    init(authManager: AuthManager, validator: ValidationManager, router: Router) {
        self.authManager = authManager
        self.validator = validator
        self.router = router
    }
    
    
    
    func signUpButtonPressed() {
        
        do {
            
            try _ = validator.checkString(stringType: .userName, string: userName, stringForMatching: nil)
            try _ = validator.checkString(stringType: .email, string: userEmail, stringForMatching: nil)
            try _ = validator.checkString(stringType: .password, string: password, stringForMatching: nil)
            try _ = validator.checkString(stringType: .passwordMatch, string: passwordConfirmation, stringForMatching: password)
            
        } catch {
            
            print(error.localizedDescription)
            errorTitle = "Please, check your user name or email and password"
            errorMessage = error.localizedDescription
            showError = true
            
        }
        
        print("INPUT OK")
        
        Task {
            
            try await authManager.signUp(withEmail: userEmail, password: password, fullName: userName)
            if self.authManager.showError {
                
                self.errorTitle = "Sign in error!"
                self.errorMessage = self.authManager.error
                self.showError = true
                return
                
            } else {
                self.router.goTo(to: .exploreScreen)
            }
            
        }
        
    }
    
    func stringCheck(checkType: StringType, string: String, passwordMatch: String? = nil) -> Bool {
        var validateResult: Bool = false
        do {
            validateResult = try validator.checkString(stringType: checkType, string: string, stringForMatching: passwordMatch)
            
        } catch {
            print(error.localizedDescription)
        }
        if string == "" {
            return true
        } else {
            return validateResult
        }
        
    }
    
}
