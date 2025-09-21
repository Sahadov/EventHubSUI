//
//  UserModel.swift
//  EventHubSUI
//
//  Created by Sergey on 18.09.2025.
//

import Foundation


struct User: Identifiable, Codable {
    let id: String
    var fullname: String
    let email: String
    let photoURL:URL?
    var userIcon: String?
    var about: String?
    
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
    static var MOCK_USER = User(id: NSUUID().uuidString,
                                fullname: "Test user",
                                email: "test@gmail.com",
                                photoURL: URL(string: ""),
                                userIcon: "profileLight",
                                about: """
Enjoy your favorite dish and a lovely your friends and family and have a great time. Food from local food trucks will be available for purchase.
Enjoy your favorite dish and a lovely your friends and family and have a great time. Food from local food trucks will be available for purchase.
Enjoy your favorite dish and a lovely your friends and family and have a great time. Food from local food trucks will be available for purchase.
""")
}
