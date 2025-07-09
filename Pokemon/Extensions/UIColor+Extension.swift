//
//  UIColor+Extension.swift
//  Pokemon
//
//  Created by Steven Lie on 08/07/25.
//

import UIKit

extension UIColor {
    static var backgroundColor = UIColor(named: "BackgroundColor")
    static var textColor = UIColor(named: "TextColor")
    static var cardColor = UIColor(named: "CardColor")
    static var baseColor = UIColor.init(hexa: 0xD53B47)
    
    convenience init(hexa: Int, alpha: CGFloat = 1) {
        let mask = 0xFF
        let limit: CGFloat = 255.0
        let red = CGFloat((hexa >> 16) & mask) / limit
        let green = CGFloat((hexa >> 8) & mask) / limit
        let blue = CGFloat(hexa & mask) / limit
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
