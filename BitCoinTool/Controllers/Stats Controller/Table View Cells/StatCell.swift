//
//  StatCell.swift
//  BitCoinTool
//
//  Created by Pavel Bogart on 06/12/2017.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

class StatCell: UITableViewCell {
    
    static let reuseIdentifier = "StatCell"
    
    let chartName: UILabel = {
        let label = UILabel()
        label.text = "Market Price (USD)"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = UIColor.darkGray
        label.textAlignment = .left
        return label
    }()
    
    let chartView: ChartView = {
        let v = ChartView()
        v.backgroundColor = .clear
        return v
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(chartName)
        addSubview(chartView)
        chartName.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 25)
        chartView.anchor(top: chartName.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 5, paddingRight: 10)
    }
    
    
}
