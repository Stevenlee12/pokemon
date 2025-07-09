//
//  PokemonCell.swift
//  Pokemon
//
//  Created by Steven Lie on 08/07/25.
//

import UIKit

final class PokemonCell: UICollectionViewCell {
    
    static let cellIdentifier = "PokemonCell"
    
    lazy var pokemonImg = UIImageView().parent(view: contentView)
    lazy var pokemonName = UILabel().parent(view: contentView)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupConstraints()
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var model: PokemonModel? {
        didSet {
            guard let model else { return }
            
            pokemonImg.setImage(string: model.imageUrl?.url)
            pokemonName.text = model.name.uppercased()
        }
    }
    
    fileprivate func setupCell() {
        contentView.style {
            $0.layer.cornerRadius = 16
            $0.clipsToBounds = true
            $0.backgroundColor = .cardColor
        }
        
        pokemonImg.style {
            $0.contentMode = .scaleAspectFit
        }
        
        pokemonName.style {
            $0.text = "Pikachu"
            $0.textColor = .textColor?.withAlphaComponent(0.8)
            $0.lineBreakMode = .byWordWrapping
            $0.numberOfLines = 0
            $0.font = .systemFont(ofSize: 14, weight: .semibold)
            $0.textAlignment = .center
        }
    }
    
    fileprivate func setupConstraints() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        pokemonImg.translatesAutoresizingMaskIntoConstraints = false
        pokemonName.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: self.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            pokemonImg.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            pokemonImg.topAnchor.constraint(equalTo: contentView.topAnchor),
            pokemonImg.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            pokemonImg.widthAnchor.constraint(equalToConstant: 120),
            pokemonImg.heightAnchor.constraint(equalToConstant: 120),
            
            pokemonName.topAnchor.constraint(equalTo: pokemonImg.bottomAnchor, constant: 8),
            pokemonName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            pokemonName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            pokemonName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
}
