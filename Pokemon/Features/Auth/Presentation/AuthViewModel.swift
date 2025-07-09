//
//  AuthViewModel.swift
//  Pokemon
//
//  Created by Steven Lie on 09/07/25.
//

import Foundation
import RxSwift
import RxCocoa

final class AuthViewModel {
    private let authUseCase: AuthUseCaseProtocol
    private let disposeBag = DisposeBag()

    let authResult = BehaviorRelay<Result<UserModel>?> (value: nil)
    let isRegistered = BehaviorRelay<Bool?>(value: nil)

    init(authUseCase: AuthUseCaseProtocol) {
        self.authUseCase = authUseCase
    }

    func register(name: String, email: String, password: String) {
        let success = authUseCase.registerUser(name: name, email: email, password: password)
        isRegistered.accept(success)
    }

    func login(email: String, password: String) {
        if let user = authUseCase.loginUser(email: email, password: password) {
            authResult.accept(.success(user))
        } else {
            authResult.accept(.failure("Invalid email or password."))
        }
    }

    func checkEmailExists(_ email: String) -> Bool {
        return authUseCase.isEmailRegistered(email: email)
    }
}
