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
    
    let marketName: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.numberOfLines = 3
        return label
    }()
    
    let marketValue: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.textAlignment = .center
        return label
    }()
    
    let lastUpdated: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    let marketDescription: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 3
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCarousel()
        setupViews()
    }
    
    func setupCarousel() {
        mainView = UIView(frame: contentView.bounds)
        contentView.addSubview(mainView)
        mainView.backgroundColor = .darkGray
    }
    
    func setupViews() {
        mainView.addSubview(marketName)
        mainView.addSubview(marketValue)
        mainView.addSubview(lastUpdated)
        mainView.addSubview(marketDescription)
        
        marketName.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 5, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 30)
        marketValue.anchor(top: marketName.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 5, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 50)
        lastUpdated.anchor(top: marketValue.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 5, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 18)
        marketDescription.anchor(top: lastUpdated.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 5, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 60)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
