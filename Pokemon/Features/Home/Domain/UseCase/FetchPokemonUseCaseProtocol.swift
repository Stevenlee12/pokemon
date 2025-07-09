//
//  FetchPokemonUseCaseProtocol.swift
//  Pokemon
//
//  Created by Steven Lie on 08/07/25.
//

import Foundation

protocol FetchPokemonUseCaseProtocol {
    func executeFetchPokemons(offset: Int) -> PokemonResult
    func executeFetchPokemonDetail(id: String) -> PokemonDetailResult
    func executeFetchCachedPokemons() -> [PokemonModel]
    func executeSavePokemonToCache(_ pokemon: PokemonModel)
    func executeGetFilteredPokemons(keyword: String) -> [PokemonModel]
}
