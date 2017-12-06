//
//  LineChartView.swift
//  BitCoinTool
//
//  Created by Pavel Bogart on 06/12/2017.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit
import Charts

class LineChart: LineChartView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Line Chart Config
    
    func setup() {
        self.noDataText = "No data available."
        self.noDataTextColor = UIColor.darkGray
        self.noDataFont = UIFont.boldSystemFont(ofSize: 14)
        self.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInSine)
    }
    
}
