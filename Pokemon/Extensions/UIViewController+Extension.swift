//
//  UIViewController+Extension.swift
//  Pokemon
//
//  Created by Steven Lie on 08/07/25.
//

import UIKit

extension UIViewController {
    public func dismissKeyboardOnTap() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
