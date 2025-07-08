//
//  PokemonModel.swift
//  Pokemon
//
//  Created by Steven Lie on 08/07/25.
//

import Foundation

struct Pokemons: Codable {
    let count: Int
    let results: [PokemonListItem]?
}

struct PokemonListItem: Codable {
    let name: String
    let url: String?
}
