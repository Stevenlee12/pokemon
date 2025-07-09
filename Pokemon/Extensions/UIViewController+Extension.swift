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
    
    func showAlert(_ title: String, message: String? = nil, handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: handler)
        
        let titleAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .semibold),
            NSAttributedString.Key.foregroundColor: UIColor.textColor ?? UIColor.black
        ]
        
        let titleString = NSAttributedString(string: title, attributes: titleAttributes)
        
        let messageAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13),
            NSAttributedString.Key.foregroundColor: UIColor.textColor ?? UIColor.black
        ]
        
        let messageString = NSAttributedString(string: message ?? "", attributes: messageAttributes)
        
        alert.setValue(titleString, forKey: "attributedTitle")
        alert.setValue(messageString, forKey: "attributedMessage")
        
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlertWithCancel(_ title: String, message: String? = nil, cancelText: String? = "Cancel", okText: String? = "OK", handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
        let action = UIAlertAction(title: okText,
                                   style: .destructive, handler: handler)
    
        let cancel = UIAlertAction(title: cancelText, style: .default, handler: nil)
        
        let titleAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .semibold),
            NSAttributedString.Key.foregroundColor: UIColor.textColor ?? UIColor.black
        ]
        
        let titleString = NSAttributedString(string: title, attributes: titleAttributes)
        
        let messageAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13),
            NSAttributedString.Key.foregroundColor: UIColor.textColor ?? UIColor.black
        ]
        
        let messageString = NSAttributedString(string: message ?? "", attributes: messageAttributes)
        
        alert.setValue(titleString, forKey: "attributedTitle")
        alert.setValue(messageString, forKey: "attributedMessage")
    
        alert.addAction(action)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
    }
}
