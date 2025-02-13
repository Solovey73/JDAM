//
//  BackgroundImage.swift
//  JDAM
//
//  Created by Victor Garitskyu on 13.02.2025.
//

import UIKit

extension UIViewController {
    func setBackgroundImage(imageName: String, alpha: CGFloat = 1.0) {
        let backgroundImage = UIImage(named: imageName)
        let backgroundImageView = UIImageView(frame: self.view.frame)
        backgroundImageView.image = backgroundImage
        backgroundImageView.contentMode = .scaleToFill
        backgroundImageView.clipsToBounds = true
        backgroundImageView.alpha = alpha // Set the opacity/alpha value
        self.view.insertSubview(backgroundImageView, at: 0)
    }
}
