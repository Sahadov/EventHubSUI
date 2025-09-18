//
//  ResetViewModel.swift
//  EventHubSUI
//
//  Created by Sergey on 10.09.2025.
//

import Foundation
import SwiftUI

final class ResetViewModel: ObservableObject {
    
    private var validator: ValidationManager
    private var router: Router
    
    init(validator: ValidationManager, router: Router) {
        self.validator = validator
        self.router = router
    }
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var showError: Bool = false
    
    
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
    
    func resetButtonTapped() {
        
        router.goTo(to: .resetPasswordConfirmationScreen)
        
    }
    
}
