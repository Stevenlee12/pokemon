//
//  Result.swift
//  Pokemon
//
//  Created by Steven Lie on 08/07/25.
//

import Foundation

enum Result<T> {
    case success(T?)
    case loading
    case failure(String)
}

