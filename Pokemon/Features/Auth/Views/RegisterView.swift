//
//  RegisterView.swift
//  Pokemon
//
//  Created by Steven Lie on 09/07/25.
//

import UIKit

final class RegisterView: UIView {
    private lazy var contentView = UIView().parent(view: self)
    lazy var nameTF = TextFieldView().parent(view: contentView)
    lazy var emailTF = TextFieldView().parent(view: contentView)
    lazy var passwordTF = TextFieldView().parent(view: contentView)
    
    lazy var loginView = UIView().parent(view: contentView)
    lazy var loginLbl = UILabel().parent(view: loginView)
    lazy var loginBtn = UIButton().parent(view: loginView)
    
    lazy var registerBtn = UIButton().parent(view: contentView)
    
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
        nameTF.style {
            $0.initialize(labelText: "Name", placeholder: "Name")
            $0.textField.tag = 1
            $0.textField.returnKeyType = .next
        }
        
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
        
        registerBtn.style {
            $0.setTitle("REGISTER", for: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = .baseColor
            $0.layer.cornerRadius = 8
        }
        
        loginLbl.style {
            $0.text = "Already Have an Account?"
            $0.font = .systemFont(ofSize: 12, weight: .semibold)
            $0.textColor = .textColor?.withAlphaComponent(0.7)
        }
        
        loginBtn.style {
            $0.setTitle("Login", for: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: 12, weight: .semibold)
            $0.setTitleColor(.baseColor, for: .normal)
            $0.backgroundColor = .clear
        }
        
    }
    
    fileprivate func setupConstraints() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        nameTF.translatesAutoresizingMaskIntoConstraints = false
        emailTF.translatesAutoresizingMaskIntoConstraints = false
        passwordTF.translatesAutoresizingMaskIntoConstraints = false
        
        registerBtn.translatesAutoresizingMaskIntoConstraints = false
        
        loginView.translatesAutoresizingMaskIntoConstraints = false
        loginLbl.translatesAutoresizingMaskIntoConstraints = false
        loginBtn.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            nameTF.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            nameTF.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            nameTF.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            emailTF.topAnchor.constraint(equalTo: nameTF.bottomAnchor, constant: 16),
            emailTF.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            emailTF.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            passwordTF.topAnchor.constraint(equalTo: emailTF.bottomAnchor, constant: 16),
            passwordTF.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            passwordTF.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            loginView.topAnchor.constraint(equalTo: passwordTF.bottomAnchor, constant: 8),
            loginView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            loginView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            loginLbl.topAnchor.constraint(equalTo: loginView.topAnchor),
            loginLbl.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            loginLbl.bottomAnchor.constraint(equalTo: loginView.bottomAnchor),
            
            loginBtn.topAnchor.constraint(equalTo: loginView.topAnchor),
            loginBtn.leadingAnchor.constraint(equalTo: loginLbl.trailingAnchor, constant: 4),
            loginBtn.bottomAnchor.constraint(equalTo: loginView.bottomAnchor),
            loginBtn.trailingAnchor.constraint(lessThanOrEqualTo: loginView.trailingAnchor),
            
            registerBtn.topAnchor.constraint(greaterThanOrEqualTo: loginView.bottomAnchor, constant: 32),
            registerBtn.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            registerBtn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            registerBtn.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -48),
            registerBtn.heightAnchor.constraint(equalToConstant: 44),
            
        ])
        
        setNeedsLayout()
        layoutIfNeeded()
    }
}
