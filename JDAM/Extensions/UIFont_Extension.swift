//
//  UIFont_Extension.swift
//  JDAM
//
//  Created by Dmitry Volkov on 15/02/2025.
//

import UIKit

extension UIFont {
    
    enum SFProRoundedFont: String {
        case bold = "SFProRounded-Bold"
        case semiBold = "SFProRounded-Semibold"
        case regular = "SFProRounded-Regular"
        case heavy = "SFProRounded-Heavy"
        case medium = "SFProRounded-Medium"
        
    }
    
    enum DelaGothicOneFont: String {
        case regular = "DelaGothicOne-Regular"
        
    }
    
    class func sFProRoundedFont(ofSize fontSize: CGFloat, weight: SFProRoundedFont) -> UIFont {
        return UIFont(name: weight.rawValue, size: fontSize) ?? .systemFont(ofSize: fontSize)
    }
    
    class func delaGothicOneFont(ofSize fontSize: CGFloat, weight: DelaGothicOneFont) -> UIFont {
        return UIFont(name: weight.rawValue, size: fontSize) ?? .systemFont(ofSize: fontSize)
    }
}
