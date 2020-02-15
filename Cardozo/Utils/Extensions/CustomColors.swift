//
//  CustomColors.swift
//  IOS-Base
//
//  Created by Caio Cardozo on 16/05/19.
//  Copyright © 2019 CaioCardozo. All rights reserved.
//

import UIKit

enum AssetsColor:String{
    case blue
    case grayOpacity
    case darkgray
    case mainBege
    case mainBlue
    case mainBlueClear
    case mainPurple
    case mainGreen
    case mainOrange
    case mainYellow
    case modalShadowColor
    case grayPhotoProfile
}

extension UIColor {
    static func appColor(_ name: AssetsColor) -> UIColor? {
        return UIColor(named: name.rawValue)
    }
        
    /// Converts a hexidecimal String to UIColor
    static func hexadecimal(_ colour:String) -> UIColor? {
        
        let hex = colour.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        
        switch hex.count {
            case 3: // RGB (12-bit)
                (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
            case 6: // RGB (24-bit)
                (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
            case 8: // ARGB (32-bit)
                (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
            default:
                (a, r, g, b) = (255, 0, 0, 0)
        }
        return self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
