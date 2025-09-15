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
    
    let router: Router
    
    init(router: Router) {
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
    
}
