//
//  LoginView.swift
//  Pokemon
//
//  Created by Steven Lie on 09/07/25.
//

import UIKit

final class LoginView: UIView {
    private lazy var contentView = UIView().parent(view: self)
    lazy var emailTF = TextFieldView().parent(view: contentView)
    lazy var passwordTF = TextFieldView().parent(view: contentView)
    
    lazy var registerView = UIView().parent(view: contentView)
    lazy var registerLbl = UILabel().parent(view: registerView)
    lazy var registerBtn = UIButton().parent(view: registerView)
    
    lazy var loginBtn = UIButton().parent(view: contentView)
    
    var loginBtnTappedHandler: (() -> Void)?
    var registerBtnTappedHandler: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .backgroundColor
        
        setupConstraints()
        setupViews()
        setupInteractions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupInteractions() {
        registerBtn.addTarget(self, action: #selector(registerBtnDidTapped), for: .touchUpInside)
        loginBtn.addTarget(self, action: #selector(loginBtnDidTapped), for: .touchUpInside)
    }
    
    @objc fileprivate func registerBtnDidTapped() {
        registerBtnTappedHandler?()
    }
    
    @objc fileprivate func loginBtnDidTapped() {
        loginBtnTappedHandler?()
    }
    
    fileprivate func setupViews() {
        emailTF.style {
            $0.initialize(labelText: "Email", placeholder: "Email")
            $0.textField.tag = 2
            $0.textField.returnKeyType = .done
            $0.textField.keyboardType = .emailAddress
        }
        
        passwordTF.style {
            $0.initialize(labelText: "Password", placeholder: "Password")
            $0.textField.tag = 3
            $0.textField.returnKeyType = .done
            $0.textField.keyboardType = .default
            $0.textField.isSecureTextEntry = true
        }
        
        loginBtn.style {
            $0.setTitle("LOGIN", for: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = .baseColor
            $0.layer.cornerRadius = 8
            $0.isEnabled = false
        }
        
        registerLbl.style {
            $0.text = "Don't Have an Account?"
            $0.font = .systemFont(ofSize: 12, weight: .semibold)
            $0.textColor = .textColor?.withAlphaComponent(0.7)
        }
        
        registerBtn.style {
            $0.setTitle("Register", for: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: 12, weight: .semibold)
            $0.setTitleColor(.baseColor, for: .normal)
            $0.backgroundColor = .clear
        }
        
    }
    
    fileprivate func setupConstraints() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        emailTF.translatesAutoresizingMaskIntoConstraints = false
        passwordTF.translatesAutoresizingMaskIntoConstraints = false
        
        loginBtn.translatesAutoresizingMaskIntoConstraints = false
        
        registerView.translatesAutoresizingMaskIntoConstraints = false
        registerLbl.translatesAutoresizingMaskIntoConstraints = false
        registerBtn.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            emailTF.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            emailTF.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            emailTF.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            passwordTF.topAnchor.constraint(equalTo: emailTF.bottomAnchor, constant: 16),
            passwordTF.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            passwordTF.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            registerView.topAnchor.constraint(equalTo: passwordTF.bottomAnchor, constant: 8),
            registerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            registerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            registerLbl.topAnchor.constraint(equalTo: registerView.topAnchor),
            registerLbl.leadingAnchor.constraint(equalTo: registerView.leadingAnchor),
            registerLbl.bottomAnchor.constraint(equalTo: registerView.bottomAnchor),
            
            registerBtn.topAnchor.constraint(equalTo: registerView.topAnchor),
            registerBtn.leadingAnchor.constraint(equalTo: registerLbl.trailingAnchor, constant: 4),
            registerBtn.bottomAnchor.constraint(equalTo: registerView.bottomAnchor),
            registerBtn.trailingAnchor.constraint(lessThanOrEqualTo: registerView.trailingAnchor),
            
            loginBtn.topAnchor.constraint(greaterThanOrEqualTo: registerView.bottomAnchor, constant: 32),
            loginBtn.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            loginBtn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            loginBtn.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -48),
            loginBtn.heightAnchor.constraint(equalToConstant: 44),
            
        ])
        
        setNeedsLayout()
        layoutIfNeeded()
    }
}
