//
//  CarouselCell.swift
//  BitCoinTool
//
//  Created by Pavel Bogart on 08/12/2017.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit
import ScalingCarousel

class CarouselCell: ScalingCarouselCell {
    
    static let reuseIdentifier = "CarouselCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        mainView = UIView(frame: contentView.bounds)
        contentView.addSubview(mainView)
        mainView.backgroundColor = .darkGray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
