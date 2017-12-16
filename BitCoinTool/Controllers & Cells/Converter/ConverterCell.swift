//
//  ConverterView.swift
//  BitCoinTool
//
//  Created by Pavel Bogart on 15/12/2017.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

class ConverterCell: UICollectionViewCell {
    
    static let reuseIdentifier = "ConverterCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setup() {
        backgroundColor = .blue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
