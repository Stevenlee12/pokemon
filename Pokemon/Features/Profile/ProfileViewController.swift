//
//  ProfileViewController.swift
//  Pokemon
//
//  Created by Steven Lie on 08/07/25.
//

import UIKit
import XLPagerTabStrip

final class ProfileViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        
        navigationItem.title = "Profile"
    }
}

extension ProfileViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(image: UIImage(systemName: "person.circle"))
    }
}


