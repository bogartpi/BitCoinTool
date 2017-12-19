//
//  CurrencyCell.swift
//  BitCoinTool
//
//  Created by Pavel Bogart on 18/11/2017.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

class RateCell: UICollectionViewCell {

    // MARK: - Type Properties

    let countryImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    let currencyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = UIColor.gray
        label.textAlignment = .left
        label.text = ""
        return label
    }()
    
    let buyTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor.darkGray
        label.textAlignment = .center
        label.text = "BUY"
        return label
    }()
    
    let buyValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor.gray
        label.textAlignment = .center
        return label
    }()
    
    let sellTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor.darkGray
        label.textAlignment = .center
        label.text = "SELL"
        return label
    }()
    
    let sellValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor.gray
        label.textAlignment = .center
        return label
    }()
    
    static let reuseIdentifier = "CurrencyCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setup() {
        backgroundColor = UIColor.white
        let buyStackView = setStackView(with: [buyTitleLabel, buyValueLabel])
        let sellStackView = setStackView(with: [sellTitleLabel, sellValueLabel])
        
        self.addSubview(countryImage)
        self.addSubview(currencyLabel)
        self.addSubview(buyStackView)
        self.addSubview(sellStackView)
        
        countryImage.anchor(left: leftAnchor, paddingLeft: 10, width: 20, height: 20)
        countryImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        currencyLabel.anchor(left: countryImage.rightAnchor, paddingLeft: 10, width: 50, height: 30)
        currencyLabel.centerYAnchor.constraint(equalTo: countryImage.centerYAnchor).isActive = true
        
        buyStackView.anchor(top: nil, left: nil, bottom: nil, right: sellStackView.leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 120, height: 0)
        buyStackView.centerYAnchor.constraint(equalTo: currencyLabel.centerYAnchor).isActive = true
        
        sellStackView.anchor(top: nil, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 10, width: 100, height: 0)
        sellStackView.centerYAnchor.constraint(equalTo: buyStackView.centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
