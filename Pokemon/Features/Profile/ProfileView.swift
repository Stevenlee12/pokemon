//
//  ProfileView.swift
//  Pokemon
//
//  Created by Steven Lie on 08/07/25.
//

import UIKit

final class ProfileView: UIView {
    lazy var contentView = UIView().parent(view: self)
    lazy var greetingLbl = UILabel().parent(view: contentView)
    lazy var nameLbl = UILabel().parent(view: contentView)
    lazy var emailLbl = UILabel().parent(view: contentView)
    
    lazy var logoutBtn = UIButton().parent(view: contentView)
    
    var logoutBtnDidTapped: (() -> Void)?
    
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
    
    fileprivate func setupViews() {
        greetingLbl.style {
            $0.text = "HELLO,"
            $0.font = .systemFont(ofSize: 12, weight: .bold)
            $0.textColor = .gray
        }
        
        nameLbl.style {
            $0.text = UserDefaults.standard.string(forKey: "name") ?? "User"
            $0.font = .systemFont(ofSize: 20, weight: .semibold)
            $0.textColor = .textColor
            $0.lineBreakMode = .byWordWrapping
            $0.numberOfLines = 0
        }
        
        emailLbl.style {
            $0.text = UserDefaults.standard.string(forKey: "email") ?? "-"
            $0.font = .systemFont(ofSize: 16)
            $0.textColor = .textColor?.withAlphaComponent(0.7)
            $0.lineBreakMode = .byWordWrapping
            $0.numberOfLines = 0
        }
        
        logoutBtn.style {
            $0.setTitle("LOGOUT", for: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = UIColor.init(hexa: 0xD53B47)
            $0.layer.cornerRadius = 8
        }
    }
    
    fileprivate func setupInteractions() {
        logoutBtn.addTarget(self, action: #selector(logoutBtnTapped), for: .touchUpInside)
    }
    
    @objc fileprivate func logoutBtnTapped() {
        logoutBtnDidTapped?()
    }
    
    fileprivate func setupConstraints() {
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        greetingLbl.translatesAutoresizingMaskIntoConstraints = false
        nameLbl.translatesAutoresizingMaskIntoConstraints = false
        emailLbl.translatesAutoresizingMaskIntoConstraints = false
        logoutBtn.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            greetingLbl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            greetingLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            greetingLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            nameLbl.topAnchor.constraint(equalTo: greetingLbl.bottomAnchor, constant: 4),
            nameLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            nameLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            emailLbl.topAnchor.constraint(equalTo: nameLbl.bottomAnchor, constant: 8),
            emailLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            emailLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            logoutBtn.topAnchor.constraint(greaterThanOrEqualTo: emailLbl.bottomAnchor, constant: 32),
            logoutBtn.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            logoutBtn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            logoutBtn.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -48),
            logoutBtn.heightAnchor.constraint(equalToConstant: 44),
            
        ])
    
        setNeedsLayout()
        layoutIfNeeded()
    }
    
}
