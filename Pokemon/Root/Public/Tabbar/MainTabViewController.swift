//
//  MainTabViewController.swift
//  Pokemon
//
//  Created by Steven Lie on 08/07/25.
//

import UIKit
import XLPagerTabStrip

class MainTabViewController: ButtonBarPagerTabStripViewController {
    
    override func viewDidLoad() {
        // Configure appearance before super
        view.backgroundColor = .white
        
        settings.style.selectedBarBackgroundColor = .systemBlue
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.buttonBarItemTitleColor = .black
        settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 14)
        settings.style.selectedBarHeight = 2.0
        
//        buttonBarView.register(
//            UINib(nibName: "TabIconTitleCell", bundle: nil),
//            forCellWithReuseIdentifier: "TabIconTitleCell"
//        )
        
//        buttonBarView.cellForItem = { collectionView, indexPath in
//            return collectionView.dequeueReusableCell(withReuseIdentifier: "TabIconTitleCell", for: indexPath)
//        }
        
//        buttonBarView.register(TabIconTitleCell.self, forCellWithReuseIdentifier: TabIconTitleCell.cellIdentifier)
//
//        buttonBarView.configureCell = { cell, indicatorInfo in
//            guard let cell = cell as? TabIconTitleCell else { return }
//            cell.label.text = indicatorInfo.title
//            let iconName = indicatorInfo.userInfo?["icon"] as? String ?? "star"
//            cell.imageView.image = UIImage(systemName: iconName)
//            cell.imageView.tintColor = .systemBlue
//        }
        
        super.viewDidLoad()
        
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        setupLayout()
    }
    
    override func configureCell(_ cell: ButtonBarViewCell, indicatorInfo: IndicatorInfo) {
        super.configureCell(cell, indicatorInfo: indicatorInfo)

        guard let cell = cell as? TabIconTitleCell else { return }
        cell.label.text = indicatorInfo.title
        cell.iconImageView.image = indicatorInfo.image
    }
    
    private func setupLayout() {
        buttonBarView.removeFromSuperview()
        containerView.removeFromSuperview()

        view.addSubview(containerView)
        view.addSubview(buttonBarView)

        buttonBarView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            buttonBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            buttonBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            buttonBarView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            buttonBarView.heightAnchor.constraint(equalToConstant: 60),

            containerView.topAnchor.constraint(equalTo: view.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: buttonBarView.topAnchor)
        ])
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return [
            HomeInjection.provideHomeViewController(),
            ProfileViewController()
        ]
    }
}
