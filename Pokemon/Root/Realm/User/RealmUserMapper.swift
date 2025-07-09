//
//  RealmUserMapper.swift
//  Pokemon
//
//  Created by Steven Lie on 09/07/25.
//

import RealmSwift

struct RealmUserMapper {
    static func from(_ model: UserModel) -> RealmUser {
        let obj = RealmUser()
        obj.email = model.email
        obj.password = model.password
        obj.name = model.name
        
        return obj
    }

    static func toModel(_ obj: RealmUser) -> UserModel {
        return UserModel(email: obj.email, password: obj.password, name: obj.name)
    }
}
