//
//  CarouselCell.swift
//  BitCoinTool
//
//  Created by Pavel Bogart on 08/12/2017.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

class CarouselCell: UICollectionViewCell {
    
    static let reuseIdentifier = "CarouselCell"
    
    let marketName: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textAlignment = .center
        label.numberOfLines = 3
        return label
    }()
    
    let marketValue: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 45)
        label.textAlignment = .center
        return label
    }()
    
    let lastUpdated: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    let marketDescription: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 5
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        let stackView = UIStackView(arrangedSubviews: [marketName,
                                                       marketValue,
                                                       lastUpdated,
                                                       marketDescription])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillProportionally
        
        self.addSubview(stackView)
        stackView.anchor(top: topAnchor,
                         left: leftAnchor,
                         bottom: bottomAnchor,
                         right: rightAnchor,
                         paddingTop: 10, paddingLeft: 20,
                         paddingBottom: 10, paddingRight: 20)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
