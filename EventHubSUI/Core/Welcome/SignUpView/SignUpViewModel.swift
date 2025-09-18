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
    
    @Published var userName: String = ""
    @Published var userEmail: String = ""
    @Published var password: String = ""
    @Published var passwordConfirmation: String = ""
    @Published var showError: Bool = false
    
    init(validator: ValidationManager, router: Router) {
        self.validator = validator
        self.router = router
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
