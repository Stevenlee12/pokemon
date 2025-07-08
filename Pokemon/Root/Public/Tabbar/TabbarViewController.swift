//
//  TabbarViewController.swift
//  Pokemon
//
//  Created by Steven Lie on 08/07/25.
//

import UIKit

final class TabbarViewController: UIViewController {
    lazy var root = TabbarView()
    let mainTabVC = MainTabViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(root)
        
        root.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            root.topAnchor.constraint(equalTo: view.topAnchor),
            root.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            root.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            root.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        root.embedPagerController(mainTabVC, into: self)
    }
}
