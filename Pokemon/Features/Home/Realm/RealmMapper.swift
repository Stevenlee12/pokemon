//
//  RealmMapper.swift
//  Pokemon
//
//  Created by Steven Lie on 08/07/25.
//

import Foundation

struct RealmMapper {
    static func from(_ model: PokemonModel) -> RealmPokemon {
        let obj = RealmPokemon()
        obj.name = model.name
        obj.imageUrl = model.imageUrl?.url ?? ""
        obj.abilities.append(objectsIn: model.abilities?.map { $0.ability.name } ?? [])
        return obj
    }

    static func toModel(_ obj: RealmPokemon) -> PokemonModel {
        return PokemonModel(
            name: obj.name,
            imageUrl: Sprite(url: obj.imageUrl),
            abilities: obj.abilities.map { Ability(ability: PokemonListItem(name: $0, url: nil)) }
        )
    }
}
