//
//  UIImageView+Extension.swift
//  Pokemon
//
//  Created by Steven Lie on 08/07/25.
//

import Foundation
import Photos
import UIKit
import Kingfisher

extension UIImageView {
    func setRounded() {
        let radius = 25
        self.layer.cornerRadius = CGFloat(radius)
        self.layer.masksToBounds = true
    }

    func setImage(string: String?) {
        guard let string = string,
              let url = string.getCleanedURL()
        else {
            self.image = UIImage(named: "brokenImage")
            return
        }

        let imageResource = KF.ImageResource(downloadURL: url)
        self.kf.indicatorType = .activity
        self.kf.setImage(with: imageResource)
    }

    func setImage(url: URL?) {
        guard let url = url
        else {
            self.image = UIImage(named: "brokenImage")
            return
        }

        let imageResource = KF.ImageResource(downloadURL: url)
        self.kf.indicatorType = .activity
        self.kf.setImage(with: imageResource)
    }
}
