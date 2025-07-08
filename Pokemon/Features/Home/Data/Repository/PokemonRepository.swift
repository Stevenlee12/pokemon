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
}
