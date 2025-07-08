//
//  NetworkManager.swift
//  Pokemon
//
//  Created by Steven Lie on 08/07/25.
//

import UIKit
import Alamofire
import RxSwift

protocol NetworkManagerProtocol {
    func request<T: Codable>(router: APIAction?, session: Session?, type model: T.Type) -> Single<T>
}

class NetworkManager: NetworkManagerProtocol {
    func request<T: Codable>(router: APIAction?, session: Session?, type model: T.Type) -> Single<T> {
        guard let router = router else {
            return Single.error(AFError.invalidURL(url: "Invalid Router"))
        }
        
        return Single<T>.create { single in
            let request = session?
                .request(router, interceptor: nil)
                .validate(statusCode: 200..<500)
                .responseData { response in
                    switch response.result {
                    case .success(let data):
                        let decoder = JSONDecoder()
                        do {
                            let model = try decoder.decode(T.self, from: data)
                            single(.success(model))
                        } catch {
                            single(.failure(AFError.createURLRequestFailed(error: error)))
                        }
                    case .failure(let error):
                        single(.failure(AFError.createURLRequestFailed(error: error)))
                    }
                }
            
            return Disposables.create {
                request?.cancel()
            }
        }
    }
}
