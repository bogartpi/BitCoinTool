//
//  CarouselCell.swift
//  BitCoinTool
//
//  Created by Pavel Bogart on 08/12/2017.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

class StatCell: UICollectionViewCell {
    
    let marketName: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.customDarkBlueColor
        label.font = UIFont.boldSystemFont(ofSize: 23)
        label.textAlignment = .left
        label.numberOfLines = 3
        return label
    }()
    
    let marketValue: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.customBlueColor
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.textAlignment = .left
        return label
    }()
    
    let lastUpdated: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 2
        label.textAlignment = .left
        return label
    }()
    
    let marketDescription: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 10
        label.textAlignment = .left
        return label
    }()
    
    let arrowImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "up-arrow")
        return iv
    }()
    
    let valueChangesLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.customDarkBlueColor
        label.font = UIFont.systemFont(ofSize: 13)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.text = "Not available"
        return label
    }()
    
    static let reuseIdentifier = "statCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    func setupViews() {
        backgroundColor = .white
    
        let stackView = UIStackView(arrangedSubviews: [marketName,
                                                       marketValue,
                                                       lastUpdated,
                                                       marketDescription])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 1
        
        let rightStackView = UIStackView(arrangedSubviews: [arrowImageView,
                                                            valueChangesLabel])
        rightStackView.axis = .vertical
        rightStackView.distribution = .fillEqually
        rightStackView.spacing = 2
        
        self.addSubview(stackView)
        self.addSubview(rightStackView)

        stackView.anchor(top: topAnchor,
                         left: leftAnchor,
                         bottom: bottomAnchor,
                         right: rightStackView.leftAnchor,
                         paddingTop: 10, paddingLeft: 8,
                         paddingBottom: 10, paddingRight: 8)
        rightStackView.anchor(top: nil,
                              left: nil,
                              bottom: nil,
                              right: rightAnchor,
                              paddingTop: 0, paddingLeft: 0,
                              paddingBottom: 0, paddingRight: 8,
                              width: 50, height: 70)
        rightStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
