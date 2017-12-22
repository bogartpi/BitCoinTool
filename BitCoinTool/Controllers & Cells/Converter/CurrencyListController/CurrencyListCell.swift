//
//  CurrencyListCell.swift
//  BitCoinTool
//
//  Created by Pavel Bogart on 21/12/2017.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit 

class CurrencyListCell: UITableViewCell {
    
    static let reuseIdentifier = "CurrencyListCell"
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    func setup() {
        let labelStackView = setStackView(items: [nameLabel], dist: .fillEqually, axis: .vertical)
        
        addSubview(currencyImageView)
        addSubview(labelStackView)
        addSubview(symbolLabel)
        
        currencyImageView.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 60, height: 45)
        currencyImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        labelStackView.anchor(top: nil, left: currencyImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 0, height: 40)
        labelStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        symbolLabel.anchor(top: nil, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 18, width: 0, height: 0)
        symbolLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    let currencyImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    let longNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.darkGray
        label.textAlignment = .left
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = UIColor.gray
        label.textAlignment = .left
        return label
    }()
    
    let symbolLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor.lightGray
        label.textAlignment = .center
        return label
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
