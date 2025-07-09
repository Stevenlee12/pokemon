//
//  FetchPokemonUseCase.swift
//  Pokemon
//
//  Created by Steven Lie on 08/07/25.
//

import Foundation

final class FetchPokemonUseCase: FetchPokemonUseCaseProtocol {
    private let repository: PokemonRepositoryProtocol
    
    init(repository: PokemonRepositoryProtocol) {
        self.repository = repository
    }
    
    func executeFetchPokemons(offset: Int) -> PokemonResult {
        repository.fetchPokemons(offset: offset)
    }
    
    func executeFetchPokemonDetail(id: String) -> PokemonDetailResult {
        repository.fetchPokemonDetail(id: id)
    }
    
    func executeFetchCachedPokemons() -> [PokemonModel] {
        repository.fetchCachedPokemon()
    }
    
    func executeSavePokemonToCache(_ pokemon: PokemonModel) {
        repository.savePokemonToCache(pokemon)
    }
    
    func executeGetFilteredPokemons(keyword: String) -> [PokemonModel] {
        repository.getFilteredPokemons(keyword: keyword)
    }
}
