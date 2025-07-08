//
//  PokemonModel.swift
//  Pokemon
//
//  Created by Steven Lie on 08/07/25.
//

import Foundation

struct PokemonModel: Codable {
    let name: String
    let imageUrl: Sprite?
    let abilities: [Ability]?
    
    private enum CodingKeys: String, CodingKey {
        case name
        case imageUrl = "sprites"
        case abilities
    }
}

struct Sprite: Codable {
    let url: String

    private enum CodingKeys: String, CodingKey {
        case url = "front_default"
    }
}

struct Ability: Codable {
    let ability: PokemonListItem
}
