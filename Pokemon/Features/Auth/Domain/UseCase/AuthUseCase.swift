//
//  AuthUseCase.swift
//  Pokemon
//
//  Created by Steven Lie on 09/07/25.
//

import Foundation

final class AuthUseCase: AuthUseCaseProtocol {
    private let repository: AuthRepositoryProtocol

    init(repository: AuthRepositoryProtocol) {
        self.repository = repository
    }

    func registerUser(name: String, email: String, password: String) -> Bool {
        let user = UserModel(email: email, password: password, name: name)
        return repository.registerUser(user)
    }

    func loginUser(email: String, password: String) -> UserModel? {
        return repository.loginUser(email: email, password: password)
    }

    func isEmailRegistered(email: String) -> Bool {
        return repository.isEmailRegistered(email)
    }
}
