//
//  TabIconTitleCell.swift
//  Pokemon
//
//  Created by Steven Lie on 08/07/25.
//

import UIKit
import XLPagerTabStrip

class TabIconTitleCell: ButtonBarViewCell {

    let iconImageView = UIImageView()
    private var bottomConstraint: NSLayoutConstraint?
    
    static let cellIdentifier = "TabIconTitleCell"

//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setup()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        setup()
//    }

    private func setup() {
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.contentMode = .scaleAspectFit
        contentView.addSubview(iconImageView)
        contentView.addSubview(label)

        bottomConstraint = label.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -4)

        NSLayoutConstraint.activate([
            iconImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            iconImageView.widthAnchor.constraint(equalToConstant: 24),
            iconImageView.heightAnchor.constraint(equalToConstant: 24),

            label.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 2),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bottomConstraint!
        ])
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        // Adjust bottom margin based on safe area
        let safeBottom = safeAreaInsets.bottom
        bottomConstraint?.constant = -(safeBottom > 0 ? safeBottom : 4)
    }
}


