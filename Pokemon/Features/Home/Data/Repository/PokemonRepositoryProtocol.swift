//
//  PokemonRepositoryProtocol.swift
//  Pokemon
//
//  Created by Steven Lie on 08/07/25.
//

import Foundation
import RxSwift

typealias PokemonResult = Single<Pokemons>
typealias PokemonDetailResult = Single<PokemonModel>

protocol PokemonRepositoryProtocol {
    func fetchPokemons(offset: Int) -> PokemonResult
    func fetchPokemonDetail(id: String) -> PokemonDetailResult
}
