//
//  UserModel.swift
//  EventHubSUI
//
//  Created by Sergey on 18.09.2025.
//

import Foundation


struct User: Identifiable, Codable {
    let id: String
    let fullname: String
    let email: String
    let photoURL:URL?
    
    var initials: String{
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: fullname){
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        return ""
    }
}

extension User{
    static var MOCK_USER = User(id: NSUUID().uuidString, fullname: "Test user", email: "test@gmail.com",photoURL: URL(string: ""))
}
