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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}
