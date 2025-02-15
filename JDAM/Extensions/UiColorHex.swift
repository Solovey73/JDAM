//
//  UiColorHex.swift
//  JDAM
//
//  Created by Victor Garitskyu on 13.02.2025.
//

import UIKit

enum Colors {
    static let textPrimary = UIColor(rgb: 0x3C3A3A)
    static let textSecondary = UIColor(rgb: 0xF5F4EE)
    static let categoryCellBg = UIColor(rgb: 0xEAE7DB)
    static let mainSheetBg = UIColor(rgb: 0xF5F4EE)
    static let categorySheetBg = UIColor(rgb: 0xFFD25E)
    static let white = UIColor(rgb: 0xFFFFFF)
    static let dark = UIColor(rgb: 0x000000)
}

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}
