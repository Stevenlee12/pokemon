//
//  TabbarView.swift
//  Pokemon
//
//  Created by Steven Lie on 08/07/25.
//

import UIKit

final class TabbarView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // Call this from a UIViewController that owns this view
    func embedPagerController(_ child: UIViewController, into parent: UIViewController) {
        parent.addChild(child)
        addSubview(child.view)
        child.view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            child.view.topAnchor.constraint(equalTo: topAnchor),
            child.view.leadingAnchor.constraint(equalTo: leadingAnchor),
            child.view.trailingAnchor.constraint(equalTo: trailingAnchor),
            child.view.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        child.didMove(toParent: parent)
    }
}
