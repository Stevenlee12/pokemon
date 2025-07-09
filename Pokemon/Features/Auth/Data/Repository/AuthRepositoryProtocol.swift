//
//  AuthRepositoryProtocol.swift
//  Pokemon
//
//  Created by Steven Lie on 09/07/25.
//

import Foundation

protocol AuthRepositoryProtocol {
    func registerUser(_ user: UserModel) -> Bool
    func loginUser(email: String, password: String) -> UserModel?
    func isEmailRegistered(_ email: String) -> Bool
}
