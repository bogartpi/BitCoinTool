//
//  StatDetailsCell.swift
//  BitCoinTool
//
//  Created by Pavel Bogart on 19/12/2017.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

class StatDetailsCell: UITableViewCell {
    
    static let resuseIdentifier = "statDetailCell"
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .left
        label.numberOfLines = 3
        return label
    }()
    
    let valueLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .left
        label.numberOfLines = 3
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        backgroundColor = UIColor.customBlueColor
        addSubview(dateLabel)
        addSubview(valueLabel)
        
        dateLabel.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 0, height: 30)
        dateLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        valueLabel.anchor(top: nil, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 20, width: 0, height: 30)
        valueLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
