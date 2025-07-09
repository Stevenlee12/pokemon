//
//  ProfileViewController.swift
//  Pokemon
//
//  Created by Steven Lie on 08/07/25.
//

import UIKit
import XLPagerTabStrip

final class ProfileViewController: UIViewController {
    lazy var root = ProfileView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Profile"
        view = root
        
        root.logoutBtnDidTapped = { [weak self] in
            guard let self else { return }
            
            showAlertWithCancel("Hmm", message: "Are you sure want to logout?") { _ in
                self.logout()
            }
        }
    }
    
    private let itemInfo: IndicatorInfo
    
    public init(itemInfo: IndicatorInfo) {
        self.itemInfo = itemInfo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func logout() {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        appDelegate.window?.rootViewController = UINavigationController(rootViewController: LoginViewController())
        UIView.transition(
            with: appDelegate.window!,
            duration: 0.4,
            options: .curveEaseOut,
            animations: nil,
            completion: nil
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

extension ProfileViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "PROFILE", image: UIImage(systemName: "person.crop.circle.fill"))
    }
}


