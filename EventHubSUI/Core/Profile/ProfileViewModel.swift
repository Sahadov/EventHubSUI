//
//  ProfileViewModel.swift
//  EventHubSUI
//
//  Created by Sergey on 19.09.2025.
//

import Foundation
import SwiftUI


final class ProfileViewModel: ObservableObject {
    
    @ObservedObject var authManager: AuthManager
    
    let router: Router
    
    @State var errorTitle: String = ""
    @State var errorMessage: String = ""
    @State var isShowingError: Bool = false
    
    init(authManager: AuthManager, router: Router) {
        
        self.authManager = authManager
        self.router = router
        
    }
    
    func logout() {
        authManager.signOut()
        if self.authManager.showError {
            
            self.errorTitle = "Sign in error!"
            self.errorMessage = self.authManager.error
            self.isShowingError = true
            return
            
        } else {
            self.router.goTo(to: .signInScreen)
        }
    }
}
