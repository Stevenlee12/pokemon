//
//  AuthRepository.swift
//  Pokemon
//
//  Created by Steven Lie on 09/07/25.
//

import Foundation

final class AuthRepository: AuthRepositoryProtocol {
    private let realmManager: AuthRealmManager

    init(realmManager: AuthRealmManager) {
        self.realmManager = realmManager
    }

    func registerUser(_ user: UserModel) -> Bool {
        guard !realmManager.isEmailRegistered(user.email)
        else {
            return false // email already used
        }
        
        realmManager.saveUser(user)
        
        return true
    }

    func loginUser(email: String, password: String) -> UserModel? {
        return realmManager.getUser(email: email, password: password)
    }

    func isEmailRegistered(_ email: String) -> Bool {
        return realmManager.isEmailRegistered(email)
    }
}
