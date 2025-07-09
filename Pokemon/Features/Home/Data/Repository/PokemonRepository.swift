//
//  PokemonRepository.swift
//  Pokemon
//
//  Created by Steven Lie on 08/07/25.
//

import Foundation
import Alamofire
import RxSwift

final class PokemonRepository: PokemonRepositoryProtocol {
    private let networkManager: NetworkManagerProtocol
    
    private let realmManager = RealmManager()
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func fetchPokemons(offset: Int) -> PokemonResult {
        let router = APIAction.getPokemons(offset: offset)
        
        return networkManager.request(router: router, session: .default, type: Pokemons.self)
    }
    
    func fetchPokemonDetail(id: String) -> PokemonDetailResult {
        let router = APIAction.getPokemonDetail(id: id)
        
        return networkManager.request(router: router, session: .default, type: PokemonModel.self)
    }
    
    func fetchCachedPokemon() -> [PokemonModel] {
        return realmManager.fetchAllPokemons()
    }
    
    func savePokemonToCache(_ pokemon: PokemonModel) {
        realmManager.savePokemon(pokemon)
    }
    
    func getFilteredPokemons(keyword: String) -> [PokemonModel] {
        return realmManager.searchPokemons(keyword: keyword)
    }
}
