//
//  HomeViewModel.swift
//  Pokemon
//
//  Created by Steven Lie on 08/07/25.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa

final class HomeViewModel: ObservableObject {
    // Public observable result for binding to UI
    var pokemonResult = BehaviorRelay<Result<[PokemonModel]>?>(value: .loading)
    var searchKeyword = BehaviorRelay<String>(value: "")
    
    // Private storage
    private var pokemons = [PokemonModel]()
    private var displayPokemons = [PokemonModel]()
    private var filteredPokemons = [PokemonModel]()
    
    private var fetchPokemonUseCase: FetchPokemonUseCaseProtocol
    private let disposeBag = DisposeBag()
    
    // Pagination control
    private var offset = 0
    private let limit = 10
    private var isLoading = false
    private var allDataLoaded = false
    private var totalCount = 999
    
    private var isSearching = false

    init(fetchPokemonUseCase: FetchPokemonUseCaseProtocol) {
        self.fetchPokemonUseCase = fetchPokemonUseCase
    }
    
    fileprivate func loadCachedPokemonsIfAvailable() {
        let cached = fetchPokemonUseCase.executeFetchCachedPokemons()
        
        if !cached.isEmpty {
            pokemons = cached
            displayPokemons = cached
            pokemonResult.accept(.success(displayPokemons))
        }
    }

    func fetchPokemons() {
        guard !isLoading, !allDataLoaded else { return }
        
        guard ConnectivityMonitor.shared.isConnected else {
            self.pokemonResult.accept(.failure("No internet connection."))
            return
        }
        
        isLoading = true

        if offset == 0 {
            loadCachedPokemonsIfAvailable()
        }
        
        fetchPokemonUseCase
            .executeFetchPokemons(offset: offset)
            .asObservable()
            .flatMap { [weak self] listResponse -> Observable<[PokemonModel]> in
                guard let self = self, let results = listResponse.results else {
                    self?.isLoading = false
                    return .just([])
                }
                
                self.totalCount = listResponse.count

                if results.isEmpty {
                    self.allDataLoaded = true
                    self.isLoading = false
                    return .just([])
                }

                let detailObservables: [Observable<PokemonModel>] = results.map { summary in
                    if let cached = self.fetchPokemonUseCase
                        .executeFetchCachedPokemons()
                        .first(where: { $0.name.lowercased() == summary.name.lowercased() }) {
                        return .just(cached)
                    }

                    let id = self.extractPokemonID(from: summary.url ?? "") ?? ""

                    return self.fetchPokemonUseCase
                        .executeFetchPokemonDetail(id: id)
                        .map { detail in
                            let model = PokemonModel(
                                name: detail.name.capitalized,
                                imageUrl: Sprite(url: detail.imageUrl?.url ?? ""),
                                abilities: detail.abilities
                            )
                            
                            return model
                        }
                        .asObservable()
                }

                return Observable.zip(detailObservables)
            }
            .subscribe(
                onNext: { [weak self] models in
                    guard let self = self else { return }

                    if models.isEmpty {
                        self.allDataLoaded = true
                    }

                    let newItems = models.filter { newItem in
                        !self.pokemons.contains(where: { $0.name == newItem.name })
                    }
                    
                    // save to realm and avoid duplicate items
                    newItems.forEach {
                        self.fetchPokemonUseCase.executeSavePokemonToCache($0)
                    }

                    offset += limit
                    
                    pokemons.append(contentsOf: newItems)
                    
                    if !isSearching {
                        displayPokemons.append(contentsOf: newItems)
                        pokemonResult.accept(.success(displayPokemons))
                    }
                    
                    isLoading = false
                },
                onError: { [weak self] error in
                    self?.isLoading = false
                    self?.pokemonResult.accept(.failure("Failed to load Pokémon: \(error.localizedDescription)"))
                }
            )
            .disposed(by: disposeBag)
    }

    /// Called from the view to trigger pagination
    func loadMoreIfNeeded(currentIndex: Int) {
        let thresholdIndex = pokemons.count - 1
        if currentIndex >= thresholdIndex && pokemons.count != totalCount {
            fetchPokemons()
        }
    }

    func resetData() {
        pokemons = []
        offset = 0
        allDataLoaded = false
        fetchPokemons()
    }

    func getSpecificPokemon(idx: Int) -> PokemonModel? {
        guard idx < displayPokemons.count else { return nil }
        return displayPokemons[idx]
    }

    func getPokemonsCount() -> Int {
        return displayPokemons.count
    }
    
    func searchPokemons(keyword: String) {
        isSearching = !keyword.isEmpty
        searchKeyword.accept(keyword)
        
        if isSearching {
            filteredPokemons = fetchPokemonUseCase.executeGetFilteredPokemons(keyword: keyword.lowercased())
            displayPokemons = filteredPokemons
        } else {
            displayPokemons = pokemons
        }
        
        pokemonResult.accept(.success(displayPokemons))
    }

    fileprivate func extractPokemonID(from url: String) -> String? {
        let components = url.split(separator: "/").compactMap { Int($0) }
        return components.last.map { String($0) }
    }
}
