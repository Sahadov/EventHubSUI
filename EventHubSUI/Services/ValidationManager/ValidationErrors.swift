//
//  ValidationErrors.swift
//  EventHubSUI
//
//  Created by Sergey on 16.09.2025.
//

import Foundation

enum ValidateInputError: Error {
    case wrongSymbolsEmail
    case emptyString
    case passwordIncorrect
    case passwordNotMatch
    case userNameError
    case authError
    case findNil
    case notRegisterUser
}

extension ValidateInputError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .wrongSymbolsEmail:
            return NSLocalizedString("Incorrect e-mail!", comment: "Description of invalid e-mail address")
        case .emptyString:
            return NSLocalizedString("All fields must be filled!", comment: "Description of empty string")
        case .passwordIncorrect:
            return NSLocalizedString("Incorrect password!", comment: "Description of incorrect password")
        case .passwordNotMatch:
            return NSLocalizedString("Passwords are not the same!", comment: "Description of not matching passwords")
        case .userNameError:
            return NSLocalizedString("Incorrect username!", comment: "Description of invalid user name")
        case .authError:
            return NSLocalizedString("Wrong login or password!", comment: "Authentication error")
        case .findNil:
            return NSLocalizedString("Can`t find in data base!", comment: "Return value is empty!")
        case .notRegisterUser:
            return NSLocalizedString("You are not authorized!", comment: "Пожалуйста зарегистрируйтесь или войдите!")
        }
    }
}
