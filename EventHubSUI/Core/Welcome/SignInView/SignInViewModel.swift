//
//  SignInViewModel.swift
//  EventHubSUI
//
//  Created by Sergey on 10.09.2025.
//

import Foundation
import SwiftUI

@MainActor
final class SignInViewModel: ObservableObject {
    
    @ObservedObject var authManager: AuthManager
    let validator: ValidationManager
    let router: Router
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isRemembered: Bool = false
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    @Published var errorTitle: String = ""
    @Published var isWrong: Bool = false
    
    
    init(authManager: AuthManager, validator: ValidationManager, router: Router) {
        self.authManager = authManager
        self.validator = validator
        self.router = router
    }
    
    func goToMainView() {
        router.goTo(to: .exploreScreen)
    }
    
    func goToForgotPasswordView() {
        router.goTo(to: .resetPasswordScreen)
    }
    
    func goToSignUpView() {
        router.goTo(to: .signUpScreen)
    }
    
    func signInWithGoogleTapped() {
        Task {
            
            if await authManager.signInWithGoogle() == true {
                self.goToMainView()
                
            }
        }
    }
    
    func signInButtonTapped() {
        //        var validateResult: Bool = false
        do {
            try _ = validator.checkString(stringType: .email, string: email, stringForMatching: nil)
            try _ = validator.checkString(stringType: .password, string: password, stringForMatching: nil)
            try _ = validator.checkString(stringType: .emptyString, string: email, stringForMatching: nil)
            try _ = validator.checkString(stringType: .emptyString, string: password, stringForMatching: nil)
            
        } catch {
            print(error.localizedDescription)
            errorTitle = "Please, check your email and password"
            errorMessage = error.localizedDescription
            showError = true
            return
        }
        print("SIGNIN INPUT OK")
        
        Task {
            
            try await authManager.signIn(email: email, password: password)
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
