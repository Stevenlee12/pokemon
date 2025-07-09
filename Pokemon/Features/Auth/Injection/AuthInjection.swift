//
//  AuthInjection.swift
//  Pokemon
//
//  Created by Steven Lie on 09/07/25.
//

import Foundation

enum AuthInjection {
    static func provideAuthViewModel() -> AuthViewModel {
        let realmManager = AuthRealmManager()
        let repository = AuthRepository(realmManager: realmManager)
        let useCase = AuthUseCase(repository: repository)
        
        return AuthViewModel(authUseCase: useCase)
    }
}
