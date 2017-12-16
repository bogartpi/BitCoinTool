//
//  CarouselCell.swift
//  BitCoinTool
//
//  Created by Pavel Bogart on 08/12/2017.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

class StatCell: UICollectionViewCell {
    
    static let reuseIdentifier = "statCell"
    
    let marketName: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.customDarkBlueColor
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.numberOfLines = 3
        return label
    }()
    
    let marketValue: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.customGreenColor
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.textAlignment = .center
        return label
    }()
    
    let lastUpdated: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    let marketDescription: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 10
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        backgroundColor = .white
        setDefaultShadowForCell(contentView: self.contentView)
    }
    
    func setup() {
        let stackView = UIStackView(arrangedSubviews: [marketName,
                                                       marketValue,
                                                       lastUpdated,
                                                       marketDescription])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 1
        self.addSubview(stackView)

        stackView.anchor(top: topAnchor,
                         left: leftAnchor,
                         bottom: nil,
                         right: rightAnchor,
                         paddingTop: 20, paddingLeft: 30,
                         paddingBottom: 0, paddingRight: 30, height: 150)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
