//
//  AuthRealmManager.swift
//  Pokemon
//
//  Created by Steven Lie on 09/07/25.
//

import RealmSwift

final class AuthRealmManager {
    private let realm = try! Realm()

    func saveUser(_ user: UserModel) {
        let obj = RealmUserMapper.from(user)
        try? realm.write {
            realm.add(obj, update: .modified)
        }
    }

    func getUser(email: String, password: String) -> UserModel? {
        return realm.objects(RealmUser.self)
            .filter("email == %@ AND password == %@", email, password)
            .first
            .flatMap { RealmUserMapper.toModel($0) }
    }

    func isEmailRegistered(_ email: String) -> Bool {
        return realm.objects(RealmUser.self)
            .filter("email == %@", email)
            .first != nil
    }
}
