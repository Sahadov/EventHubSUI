//
//  AuthService.swift
//  EventHubSUI
//
//  Created by Sergey on 10.09.2025.
//

import Foundation
import FirebaseAuth
import Firebase
import FirebaseCore
import FirebaseFirestore
import GoogleSignIn
import GoogleSignInSwift

enum AuthenticationError: Error {
    case tokenError(message: String)
}

@MainActor
final class AuthManager: ObservableObject {
    
    @Published var user: UserInfo?
    @Published var userSession: FirebaseAuth.User?
    @Published var isLoading: Bool = false
    @Published var currentUser:User?
    @Published var error:String =  ""
    @Published var showMessage = ""
    @Published var showError: Bool = false
    
    init() {
           self.userSession = Auth.auth().currentUser
           Task {
               await fetchUser()
           }
       }
    
    
    func signIn(email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            self.isLoading = false
            await fetchUser()
        } catch {
            self.isLoading = false
            self.error = error.localizedDescription
            self.showError = true
        }
    }
    
    
    func signOut()
        {
            do{
                try Auth.auth().signOut()
                self.userSession = nil
                self.currentUser = nil
                self.error = ""
            } catch
            {
                self.error = error.localizedDescription
            }
        }
    
    func signUp(withEmail email: String,password: String, fullName: String) async throws {
        self.isLoading = true
        do{
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, fullname: fullName, email: email,photoURL: URL(string: ""))
            let encodeUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodeUser)
            self.isLoading = false
            await fetchUser()
        } catch{
            self.error = error.localizedDescription
            self.isLoading = false
            
        }
    }
    
    func resetPassword(email: String) async throws{
        self.isLoading = true
        do {
            try await Auth.auth().sendPasswordReset(withEmail: email)
            showMessage = "Link send successfully"
            self.isLoading = false
        } catch {
            showMessage = error.localizedDescription
            self.error = error.localizedDescription
            self.isLoading = false
            print("Error sending password reset email: \(error.localizedDescription)")
        }
    }
    
    func updatePassword(password:String) async throws{
        self.isLoading = true
        do{
            try await userSession?.updatePassword(to: password)
            self.isLoading = false
        } catch {
            self.error = error.localizedDescription
            self.isLoading = false
            print("Error sending password reset email: \(error.localizedDescription)")
        }
    }
    
    func fetchUser() async {
            guard let uid  = Auth.auth().currentUser?.uid else { return }
            guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
            self.currentUser = try? snapshot.data(as: User.self)
        }
}

extension AuthManager {
    func signInWithGoogle() async -> Bool {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            fatalError("No client ID found in Firebase configuration")
        }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first,
              let rootViewController = window.rootViewController else {
            return false
        }
        do {
            let userAuthentication = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)
            let user = userAuthentication.user
            guard let idToken = user.idToken else { throw AuthenticationError.tokenError(message: "ID token missing") }
            let accessToken = user.accessToken
            let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString,
                                                           accessToken: accessToken.tokenString)
            let result  = try await Auth.auth().signIn(with:credential)
            
            let googleuser = User(id: result.user.uid, fullname: result.user.displayName ?? "" , email: result.user.email ?? "",photoURL: result.user.photoURL ?? URL(string: ""))
            let encodeUser = try Firestore.Encoder().encode(googleuser)
            try await Firestore.firestore().collection("users").document(googleuser.id).setData(encodeUser)
            self.isLoading = false
            await fetchUser()
            self.userSession = result.user
            return true
        }
        catch {
            self.error = error.localizedDescription
            return false
        }
    }
}

