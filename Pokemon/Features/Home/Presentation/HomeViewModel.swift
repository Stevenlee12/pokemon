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
    
    // Private storage
    private var pokemons: [PokemonModel] = []
    private var cachedDetails: [String: PokemonModel] = [:]
    private var fetchPokemonUseCase: FetchPokemonUseCaseProtocol
    private let disposeBag = DisposeBag()
    
    // Pagination control
    private var offset = 0
    private let limit = 10
    private var isLoading = false
    private var allDataLoaded = false

    init(fetchPokemonUseCase: FetchPokemonUseCaseProtocol) {
        self.fetchPokemonUseCase = fetchPokemonUseCase
    }

    func fetchPokemons() {
        guard !isLoading, !allDataLoaded else { return }
        isLoading = true

        fetchPokemonUseCase
            .executeFetchPokemons(offset: offset)
            .asObservable()
            .flatMap { [weak self] listResponse -> Observable<[PokemonModel]> in
                guard let self = self, let results = listResponse.results else {
                    self?.isLoading = false
                    return .just([])
                }

                if results.isEmpty {
                    self.allDataLoaded = true
                    self.isLoading = false
                    return .just([])
                }

                let detailObservables: [Observable<PokemonModel>] = results.map { summary in
                    if let cached = self.cachedDetails[summary.name] {
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
                            self.cachedDetails[summary.name] = model
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

                    self.offset += self.limit
                    self.pokemons.append(contentsOf: models)
                    self.pokemonResult.accept(.success(self.pokemons))
                    self.isLoading = false
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
        print(currentIndex, 123)
        let thresholdIndex = pokemons.count - 1
        if currentIndex >= thresholdIndex {
            offset += limit
            fetchPokemons()
        }
    }

    func resetData() {
        pokemons = []
        offset = 0
        allDataLoaded = false
        cachedDetails = [:]
        fetchPokemons()
    }

    func getSpecificPokemon(idx: Int) -> PokemonModel? {
        guard idx < pokemons.count else { return nil }
        return pokemons[idx]
    }

    func getPokemonsCount() -> Int {
        return pokemons.count
    }

    fileprivate func extractPokemonID(from url: String) -> String? {
        let components = url.split(separator: "/").compactMap { Int($0) }
        return components.last.map { String($0) }
    }
}
