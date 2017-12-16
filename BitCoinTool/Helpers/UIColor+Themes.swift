//
//  UIColor+Themes.swift
//  BitCoinTool
//
//  Created by Pavel Bogart on 16/12/2017.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

public extension UIColor {
    public convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}

