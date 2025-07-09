//
//  RealmManager.swift
//  Pokemon
//
//  Created by Steven Lie on 08/07/25.
//

import RealmSwift

final class RealmManager {
    private let realm = try! Realm()

    func savePokemon(_ pokemon: PokemonModel) {
        let obj = RealmMapper.from(pokemon)
        try? realm.write {
            realm.add(obj, update: .modified)
        }
    }

    func fetchAllPokemons() -> [PokemonModel] {
        let results = realm.objects(RealmPokemon.self)
        return results.map { RealmMapper.toModel($0) }
    }
    
    func searchPokemons(keyword: String) -> [PokemonModel] {
        let results = realm.objects(RealmPokemon.self)
            .filter("name CONTAINS[c] %@", keyword)

        return results.map { RealmMapper.toModel($0) }
    }

    func clearAll() {
        try? realm.write {
            realm.deleteAll()
        }
    }
}
