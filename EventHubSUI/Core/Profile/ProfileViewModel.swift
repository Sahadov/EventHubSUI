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
        
        UserDefaults.standard.removeObject(forKey: "userIcon")
    
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
    
    func encodeImage(image: UIImage) -> Data {
        
        let imgData = image.jpegData(compressionQuality: 0.5)!
//        let imgString = imgData.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        return imgData
        
    }
    
    func decodeImage(data: Data) -> UIImage? {
        
        let decodedImg = NSData(base64Encoded: data, options: NSData.Base64DecodingOptions(rawValue: 0))
                
        return UIImage(data: decodedImg! as Data)
        
    }
    
    func saveUserImage(image: UIImage) {
        let imgData = encodeImage(image: image)
        print(imgData)
        self.user?.userIcon = imgData
        
        UserDefaults.standard.set(imgData, forKey: "userIcon")
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
