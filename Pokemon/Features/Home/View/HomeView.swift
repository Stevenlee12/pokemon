//
//  HomeView.swift
//  Pokemon
//
//  Created by Steven Lie on 08/07/25.
//

import UIKit

final class HomeView: UIView {
    lazy var searchBar = UISearchBar().parent(view: self)
    lazy var pokemonCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout()).parent(view: self)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupConstraints()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupViews() {
        searchBar.style {
            $0.searchBarStyle = .minimal
            $0.sizeToFit()
            $0.searchTextField.attributedPlaceholder = NSAttributedString(
                string: "Search your pokemon here",
                attributes: [
                    .foregroundColor: UIColor.black.withAlphaComponent(0.7),
                    .font: UIFont.systemFont(ofSize: 13)
                ]
            )
            
            if let textField = $0.value(forKey: "searchField") as? UITextField,
                let iconView = textField.leftView as? UIImageView {
                    
                textField.textColor = .black
                textField.font = UIFont.systemFont(ofSize: 13)
                iconView.image = iconView.image?.withRenderingMode(.alwaysTemplate)
                iconView.tintColor = .black
                
            }
        }
        
        pokemonCollectionView.style {
            $0.backgroundColor = .clear
            $0.register(PokemonCell.self, forCellWithReuseIdentifier: PokemonCell.cellIdentifier)
            $0.tag = 0
            
            $0.bounces = false
            $0.backgroundColor = .clear
            
            $0.contentInset = UIEdgeInsets(top: 0, left: 24, bottom: 24, right: 24)

            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            layout.minimumInteritemSpacing = 24
            layout.minimumLineSpacing = 24
            $0.collectionViewLayout = layout
        }
    }
    
    fileprivate func setupConstraints() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        pokemonCollectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor/*, constant: 16*/),
            searchBar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            searchBar.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            searchBar.heightAnchor.constraint(lessThanOrEqualToConstant: 48),
            
            pokemonCollectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 16),
            pokemonCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            pokemonCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            pokemonCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        
        setNeedsLayout()
        layoutIfNeeded()
    }
}
