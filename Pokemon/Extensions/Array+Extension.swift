//
//  Array+Extension.swift
//  Pokemon
//
//  Created by Steven Lie on 08/07/25.
//

import UIKit

extension Array {
    public func get(_ index: Int) -> Element? {
        guard index >= 0 && index < self.count else {
            return nil
        }
        return self[index]
    }
}

extension Array where Element: UIView {
    func style(_ callback: ((Element) -> Void)) {
        for item in self {
            callback(item)
        }
    }
}

extension Array where Element: UIBarItem {
    func style(_ callback: ((Element) -> Void)) {
        for item in self {
            callback(item)
        }
    }
}

extension Array where Element: UIGestureRecognizer {
    func style(_ callback: ((Element) -> Void)) {
        for item in self {
            callback(item)
        }
    }
}
