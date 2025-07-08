//
//  PokemonDetailViewController.swift
//  Pokemon
//
//  Created by Steven Lie on 08/07/25.
//

import UIKit

final class PokemonDetailViewController: UIViewController {
    lazy var root = PokemonDetailView()
    
    var data: PokemonModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = root
        
        root.model = data
        
        navigationItem.title = data?.name
    }
}
