//
//  UIAppearance+Extension.swift
//  Pokemon
//
//  Created by Steven Lie on 08/07/25.
//

import UIKit

extension UIAppearance {
    public func style(_ completion: @escaping ((Self) -> Void)) {
        completion(self)
    }
}
