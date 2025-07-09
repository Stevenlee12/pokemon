//
//  TextFieldView.swift
//  Pokemon
//
//  Created by Steven Lie on 09/07/25.
//

import UIKit

class TextFieldView: UIView {
    lazy var label = UILabel().parent(view: self)
    lazy var textField = UITextField().parent(view: self)
    
    init() {
        super.init(frame: CGRect())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    public func initialize(labelText: String, placeholder: String) {
        label.text = labelText
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray.withAlphaComponent(0.7)]
        )
        
        setupConstraint()
        setupView()
    }

    func replaceRightView(view: UIView?) {
        if let view = view {
            textField.rightView = view
        }
        textField.rightView = nil
    }
    
    // MARK: SET UP VIEWS
    func setupView() {
        label.style {
            $0.textColor = .textColor
            $0.font = .systemFont(ofSize: 13)
        }
        
        textField.style {
            $0.setLayer(cornerRadius: 8, borderWidth: 1, borderColor: .gray.withAlphaComponent(0.6))
            $0.textColor = .textColor
            $0.autocorrectionType = .no
            $0.backgroundColor = .cardColor?.withAlphaComponent(0.5)
            $0.font = .systemFont(ofSize: 13)
            $0.leftViewMode = .always
            $0.rightViewMode = .always
            $0.autocapitalizationType = .none
            
            let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 16))
            $0.leftView = paddingView
            $0.rightView = paddingView
        }
    }
    
    // MARK: SET UP CONSTRAINTS
    func setupConstraint() {
        label.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.topAnchor),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            textField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 8),
            textField.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            textField.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            textField.heightAnchor.constraint(equalToConstant: 40),
            
        ])
    }
}
