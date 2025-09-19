//
//  ResetViewModel.swift
//  EventHubSUI
//
//  Created by Sergey on 10.09.2025.
//

import Foundation
import SwiftUI

final class ResetViewModel: ObservableObject {
    
    @ObservedObject var validator: ValidationManager
    @ObservedObject var router: Router
    @ObservedObject var authManager: AuthManager
    
    init(validator: ValidationManager, router: Router, authManager: AuthManager) {
        self.validator = validator
        self.router = router
        self.authManager = authManager
    }
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    @Published var errorTitle: String = ""
    
    
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
    
    func sendButtonTapped() {
        do {
            try _ = validator.checkString(stringType: .email, string: email, stringForMatching: nil)
            
        } catch {
            
            print(error.localizedDescription)
            errorTitle = "Please, check your email"
            errorMessage = error.localizedDescription
            showError = true
            return
            
        }
        
        Task {
            
            try await authManager.resetPassword(email: email)
            if authManager.showError {
                
                self.errorTitle = "Reset password error!"
                self.errorMessage = self.authManager.error
                self.showError = true
                return
                
            } else {
                
                self.router.goTo(to: .signInScreen)
                
            }
        }
        
        
    }
    
    func changePasswordButtonTapped() {
        
        do {
            try _ = validator.checkString(stringType: .password, string: password, stringForMatching: nil)
            try _ = validator.checkString(stringType: .passwordMatch, string: password, stringForMatching: confirmPassword)
            
        } catch {
            
            print(error.localizedDescription)
            errorTitle = "Please, check your password"
            errorMessage = error.localizedDescription
            showError = true
            return
            
        }
        
        Task {
            try await authManager.updatePassword(password: password)
            if authManager.showError {
                
                self.errorTitle = "Change password error!"
                self.errorMessage = self.authManager.error
                self.showError = true
                return
                
            } else {
                
                authManager.signOut()
                if self.authManager.showError {
                    
                    self.errorTitle = "Sign in error!"
                    self.errorMessage = self.authManager.error
                    self.showError = true
                    return
                    
                } else {
                    
                    self.router.goTo(to: .signInScreen)
                    
                }
                
               
                
            }
                
                
            
        }
        
    }
    
}
