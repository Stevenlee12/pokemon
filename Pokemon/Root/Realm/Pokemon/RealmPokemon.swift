//
//  RealmPokemon.swift
//  Pokemon
//
//  Created by Steven Lie on 08/07/25.
//

import RealmSwift

class RealmPokemon: Object {
    @Persisted(primaryKey: true) var name: String
    @Persisted var imageUrl: String
    @Persisted var abilities = List<String>()
}
