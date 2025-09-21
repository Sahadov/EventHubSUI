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
    
    @ObservedObject  var router: Router
    
    @State var userImage: String = ""
    @State var aboutUser: String = ""
    
    @State var errorTitle: String = ""
    @State var errorMessage: String = ""
    @State var isShowingError: Bool = false
    @Published var user: User?
    
    init(authManager: AuthManager, router: Router) {
        self.authManager = authManager
        self.router = router
        Task {
            await authManager.fetchUser()
            self.user = authManager.currentUser ?? User.MOCK_USER
        }
    }
    
    func logout() {
    
        authManager.signOut()
        if self.authManager.showError {
            
            self.errorTitle = "Sign out error!"
            self.errorMessage = self.authManager.error
            self.isShowingError = true
            return
            
        } else {
            self.router.goTo(to: .signInScreen)
        }
    }
    
    func updateUser() {
        isShowingError = true
        if let user = user {
            Task {
                do {
                    try await authManager.updateUserData(user: user)
                } catch {
                    self.errorTitle = "Update user error!"
                    self.errorMessage = error.localizedDescription
                    self.isShowingError = true
                    return
                }
            }
        }
    }
}
