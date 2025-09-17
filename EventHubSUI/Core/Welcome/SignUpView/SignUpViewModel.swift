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
    
    let validator: ValidationManager
    let router: Router
    
    init(validator: ValidationManager, router: Router) {
        self.validator = validator
        self.router = router
    }
    
    func goToSignInView() {
        
        
    }
    
    func signUpButtonPressed() {
        
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
