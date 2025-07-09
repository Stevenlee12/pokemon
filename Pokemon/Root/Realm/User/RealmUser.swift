//
//  RealmUser.swift
//  Pokemon
//
//  Created by Steven Lie on 09/07/25.
//

import RealmSwift

final class RealmUser: Object {
    @Persisted(primaryKey: true) var email: String
    @Persisted var password: String
    @Persisted var name: String
}
