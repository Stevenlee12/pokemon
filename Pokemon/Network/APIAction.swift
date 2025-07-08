//
//  APIAction.swift
//  Pokemon
//
//  Created by Steven Lie on 08/07/25.
//

import Foundation
import Alamofire

enum APIAction {
    case getPokemons(offset: Int)
    case getPokemonDetail(id: String)
}

extension APIAction: APIRouter {
    var method: HTTPMethod {
        switch self {
        case .getPokemons, .getPokemonDetail:
            return .get
        }
    }

    var path: String {
        switch self {
        case .getPokemons(let offset):
            return "pokemon?offset=\(offset)&limit=10"
        case .getPokemonDetail(let id):
            return "pokemon/\(id)"
        }
    }
    
    private var apiKey: String {
        guard let filePath = Bundle.main.path(forResource: "Info", ofType: "plist")
        else {
            fatalError("Couldn't find file 'Info.plist'.")
        }
        
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "API_KEY") as? String
        else {
          fatalError("Couldn't find key 'API_KEY' in 'Info.plist'.")
        }
        
        return value
    }

    var actionParameters: [String: Any] {
        switch self {
        case .getPokemons, .getPokemonDetail:
            return [:]
        }
    }

    var baseURL: String {
        return "https://pokeapi.co/api/v2/"
    }

    var authHeader: HTTPHeaders? {
        switch self {
        default:
            return [:]
        }
    }
}
