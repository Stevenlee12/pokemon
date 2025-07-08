//
//  PokemonDetailView.swift
//  Pokemon
//
//  Created by Steven Lie on 08/07/25.
//

import UIKit

final class PokemonDetailView: UIView {
    
    lazy var contentView = UIView().parent(view: self)
    lazy var pokemonNameLbl = UILabel().parent(view: contentView)
    
    lazy var abilitiesTitleLbl = UILabel().parent(view: contentView)
    lazy var abilitiesLbl = UILabel().parent(view: contentView)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        setupConstraints()
        setupViews()
    }
    
    var model: PokemonModel? {
        didSet {
            guard let model else { return }
            
            pokemonNameLbl.text = model.name
            
            if let abilities = model.abilities {
                abilitiesLbl.text = abilities
                    .map { $0.ability.name.capitalized }
                    .joined(separator: "\n")
            } else {
                abilitiesLbl.text = "-"
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupViews() {
        pokemonNameLbl.style {
            $0.font = .systemFont(ofSize: 24, weight: .bold)
            $0.textColor = .black
        }
        
        abilitiesLbl.style {
            $0.font = .systemFont(ofSize: 16)
            $0.textColor = .black
            $0.lineBreakMode = .byWordWrapping
            $0.numberOfLines = 0
        }
        
        abilitiesTitleLbl.style {
            $0.font = .systemFont(ofSize: 14, weight: .semibold)
            $0.textColor = .gray
            $0.text = "Abilities: "
        }
    }
    
    fileprivate func setupConstraints() {
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        pokemonNameLbl.translatesAutoresizingMaskIntoConstraints = false
        abilitiesTitleLbl.translatesAutoresizingMaskIntoConstraints = false
        abilitiesLbl.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            pokemonNameLbl.topAnchor.constraint(equalTo: contentView.topAnchor),
            pokemonNameLbl.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            pokemonNameLbl.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            abilitiesTitleLbl.topAnchor.constraint(equalTo: pokemonNameLbl.bottomAnchor, constant: 16),
            abilitiesTitleLbl.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            abilitiesTitleLbl.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            abilitiesLbl.topAnchor.constraint(equalTo: abilitiesTitleLbl.bottomAnchor, constant: 4),
            abilitiesLbl.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            abilitiesLbl.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            abilitiesLbl.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor),
        ])
        
        setNeedsLayout()
        layoutIfNeeded()
    }
}
