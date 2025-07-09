//
//  AuthUseCaseProtocol.swift
//  Pokemon
//
//  Created by Steven Lie on 09/07/25.
//

import Foundation

protocol AuthUseCaseProtocol {
    func registerUser(name: String, email: String, password: String) -> Bool
    func loginUser(email: String, password: String) -> UserModel?
    func isEmailRegistered(email: String) -> Bool
}
