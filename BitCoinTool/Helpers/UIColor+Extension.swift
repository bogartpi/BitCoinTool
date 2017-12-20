//
//  UIColor+Themes.swift
//  BitCoinTool
//
//  Created by Pavel Bogart on 16/12/2017.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

public extension UIColor {
    convenience init(netHex:Int) {
        let components = (
            R: CGFloat((netHex >> 16) & 0xff) / 255,
            G: CGFloat((netHex >> 08) & 0xff) / 255,
            B: CGFloat((netHex >> 00) & 0xff) / 255
        )
        self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
    }
}

public extension UIColor {
    public convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}

public extension UIColor {
    func inverse () -> UIColor {
        var r:CGFloat = 0.0; var g:CGFloat = 0.0; var b:CGFloat = 0.0; var a:CGFloat = 0.0;
        if self.getRed(&r, green: &g, blue: &b, alpha: &a) {
            return UIColor(red: 1.0-r, green: 1.0 - g, blue: 1.0 - b, alpha: a)
        }
        return .black
    }
}

public extension UIColor {
    
    static var customGreenColor: UIColor = {
        return UIColor(r: 98, g: 200, b: 177)
    }()
    
    static var customDarkBlueColor: UIColor = {
        return UIColor(r: 42, g: 89, b: 143)
    }()
    
    static var customGrayColor: UIColor = {
        return UIColor(r: 54, g: 49, b: 49)
    }()
    
    static var customDarkGrayColor: UIColor = {
        return UIColor(r: 38, g: 37, b: 37)
    }()
    
    static var customRedColor: UIColor = {
        return UIColor(r: 239, g: 83, b: 80)
    }()
    
    static var customWhitecolor: UIColor = {
        return UIColor(r: 245, g: 245, b: 245)
    }()
    
    static var customWhiteDarkColor: UIColor = {
        return UIColor(r: 238, g: 238, b: 238)
    }()
    
    static var customBlueColor: UIColor = {
        return UIColor(r: 73, g: 144, b: 226)
    }()
    
    static var customWarningColor: UIColor = {
        return UIColor(r: 244, g: 67, b: 54)
    }()
    
    static var customYellowColor: UIColor = {
        return UIColor(r: 245, g: 166, b: 35)
    }()
}
