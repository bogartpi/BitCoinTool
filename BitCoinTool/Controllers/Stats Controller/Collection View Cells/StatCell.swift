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
    
    var chartName: UILabel = {
        let label = UILabel()
        label.text = "Market Price (USD)"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = UIColor.darkGray
        label.textAlignment = .left
        return label
    }()
    
    var chartDescription: UILabel = {
        let label = UILabel()
        label.text = "Market Price (USD)"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = UIColor.gray
        label.textAlignment = .left
        return label
    }()
    
    let lineChartView: LineChart = {
        let v = LineChart()
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
        addSubview(chartDescription)
        addSubview(lineChartView)
        chartName.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 20)
        chartDescription.anchor(top: chartName.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 2, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 20)
        lineChartView.anchor(top: chartDescription.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 5, paddingRight: 10)
    }
    
    
    
    
}
