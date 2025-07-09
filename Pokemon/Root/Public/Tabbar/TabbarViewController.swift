//
//  TabbarViewController.swift
//  Pokemon
//
//  Created by Steven Lie on 08/07/25.
//

import UIKit
import XLPagerTabStrip

class TabbarViewController: BaseButtonBarPagerTabStripViewController<TabIconTitleCell> {
    let unselectedIconColor = UIColor.init(hexa: 0x49080A)
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        buttonBarItemSpec = ButtonBarItemSpec.cellClass(width: { _ in 70.0 })
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        buttonBarItemSpec = ButtonBarItemSpec.cellClass(width: { _ in 70.0 })
    }
    
    override func viewDidLoad() {
        // change selected bar color
        settings.style.buttonBarBackgroundColor = .baseColor
        settings.style.buttonBarItemBackgroundColor = .clear
        settings.style.selectedBarBackgroundColor = UIColor(red: 234/255.0, green: 234/255.0, blue: 234/255.0, alpha: 1.0)
        settings.style.selectedBarHeight = 0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .black
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        
        super.viewDidLoad()
        edgesForExtendedLayout = []
        
        view.backgroundColor = .backgroundColor
        
        setupLayout()
        
        buttonBarView.register(TabIconTitleCell.self, forCellWithReuseIdentifier: TabIconTitleCell.cellIdentifier)

        changeCurrentIndexProgressive = { [weak self] (oldCell: TabIconTitleCell?, newCell: TabIconTitleCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard let self, changeCurrentIndex == true else { return }
            
            oldCell?.iconImageView.tintColor = unselectedIconColor.withAlphaComponent(0.6)
            oldCell?.label.textColor = unselectedIconColor
            
            newCell?.iconImageView.tintColor = .white
            newCell?.label.textColor = .white
        }
        
    }
    
    private func setupLayout() {
        buttonBarView.removeFromSuperview()
        containerView.removeFromSuperview()

        view.addSubview(containerView)
        view.addSubview(buttonBarView)

        buttonBarView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.bounces = false
        buttonBarView.bounces = false

        NSLayoutConstraint.activate([
            buttonBarView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            buttonBarView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            buttonBarView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            buttonBarView.heightAnchor.constraint(equalToConstant: 75),

            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: buttonBarView.topAnchor)
        ])
    }

    // MARK: - PagerTabStripDataSource

    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let child_1 = HomeInjection.provideHomeViewController()
        let child_2 = ProfileViewController(itemInfo: IndicatorInfo(title: "Profile", image: UIImage(systemName: "profile")))
        return [child_1, child_2]
    }

    override func configure(cell: TabIconTitleCell, for indicatorInfo: IndicatorInfo) {
        cell.iconImageView.image = indicatorInfo.image?.withRenderingMode(.alwaysTemplate)
        cell.label.text = indicatorInfo.title?.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    override func updateIndicator(for viewController: PagerTabStripViewController, fromIndex: Int, toIndex: Int, withProgressPercentage progressPercentage: CGFloat, indexWasChanged: Bool) {
        super.updateIndicator(for: viewController, fromIndex: fromIndex, toIndex: toIndex, withProgressPercentage: progressPercentage, indexWasChanged: indexWasChanged)
        if indexWasChanged && toIndex > -1 && toIndex < viewControllers.count {
            let child = viewControllers[toIndex] as! IndicatorInfoProvider // swiftlint:disable:this force_cast
            UIView.performWithoutAnimation({ [weak self] () -> Void in
                guard let me = self else { return }
                me.navigationItem.leftBarButtonItem?.title =  child.indicatorInfo(for: me).title
            })
        }
    }
}

