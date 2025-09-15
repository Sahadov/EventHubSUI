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
    
    let validator: ValidationManager
    let router: Router
    
    init(validator: ValidationManager, router: Router) {
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
    
    func emailCheck(email: String) -> Bool {
        var validateResult: Bool = false
        do {
            
            validateResult = try validator.checkString(stringType: .email, string: email, stringForMatching: nil)
            
        } catch {
            print(error.localizedDescription)
        }
        if email == "" {
            return true
        } else {
            return validateResult
        }
        
    }
    
    func passwordCheck(password: String) -> Bool {
        var validateResult: Bool = false
        do {
            
            validateResult = try validator.checkString(stringType: .password, string: password, stringForMatching: nil)
            
        } catch {
            print(password)
            print(error.localizedDescription)
        }
        if password == "" {
            return true
        } else {
            return validateResult
        }
    }
}
