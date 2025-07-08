//
//  HomeInjection.swift
//  Pokemon
//
//  Created by Steven Lie on 08/07/25.
//

import Foundation

final class HomeInjection {
    static func provideHomeViewController() -> HomeViewController {
        let networkManager = NetworkManager()
        let repository = PokemonRepository(networkManager: networkManager)
        let useCase = FetchPokemonUseCase(repository: repository)
        let viewModel = HomeViewModel(fetchPokemonUseCase: useCase)
        
        return HomeViewController(viewModel: viewModel)
    }
}
