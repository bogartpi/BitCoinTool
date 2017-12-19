//
//  StatDetailsController.swift
//  BitCoinTool
//
//  Created by Pavel Bogart on 18/12/2017.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit
import Charts

class StatDetailsController: UIViewController {
    
    // MARK: - Properties
    
    let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "close"), for: .normal)
        button.addTarget(self, action: #selector(dismissController), for: .touchUpInside)
        return button
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.customBlueColor
        return tableView
    }()
    
    var marketValues: Market? {
        didSet {
            self.values = marketValues?.values
            self.values = values?.sorted(by: {$0.dateX > $1.dateX})
        }
    }
    var values: [Value]? {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    var chart: LineChartView!
    var graphDescription: String?
    var selectedIndexPath: IndexPath?
    var descriptionLabel: UILabel!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setupViews()
    }
    
    // MARK: - Setup Views
    
    private func configure() {
        chart = self.addLineChartView()
        chart.delegate = self

        self.chart.setData(dataPoints: (self.values?.map({$0.dateX}).reversed())!, values: (self.values?.map({$0.valueY}).reversed())!, label: "PIB", lineColor: self.view.backgroundColor?.inverse())
        
        self.tableView.presentTableViewAnimated(y: self.view.bounds.size.height, completion: {
            guard let marketName = self.marketValues?.name else { return }
            self.descriptionLabel.text = "* \(marketName)"
        })
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(StatDetailsCell.self, forCellReuseIdentifier: StatDetailsCell.resuseIdentifier)
    }
    
    private func setupViews() {
        view.backgroundColor = UIColor.customBlueColor
        view.addSubview(closeButton)
        view.addSubview(tableView)
        view.addSubview(chart)
        
        closeButton.anchor(top: view.safeTopAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 15, paddingLeft: 15, paddingBottom: 0, paddingRight: 0, width: 20, height: 20)
        
        tableView.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: view.frame.height / 2)
        
        chart.anchor(top: view.safeTopAnchor, left: view.leftAnchor, bottom: tableView.topAnchor, right: view.rightAnchor, paddingTop: 35, paddingLeft: 0, paddingBottom: 20, paddingRight: 0, width: 0, height: 0)
        
        descriptionLabel = self.addReferenceLabel(text: "", color: UIColor.white, view: chart)
    }
    
    // MARK: - Configure Table View Cell
    
    private func configureCell(_ cell: StatDetailsCell, at indexPath: IndexPath) {
        guard let value = values?[indexPath.row] else { fatalError() }
        let convertedDate = convertToDate(value: value.dateX, style: .medium)
        let convertedValue = convertToLargeNumber(number: Int(value.valueY))
        cell.dateLabel.text = convertedDate
        cell.valueLabel.text = String(convertedValue)
    }
    
    @objc func dismissController(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - Table View Methods

extension StatDetailsController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = values?.count else { return 0 }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StatDetailsCell.resuseIdentifier, for: indexPath) as! StatDetailsCell
        configureCell(cell, at: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}

// MARK: - Line Chart Methods

extension StatDetailsController: ChartViewDelegate {
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        selectedIndexPath = chartView.selectIn(tableView: tableView, arrayCount: (values?.count)!, xEntry: Int(entry.x))
    }
    
    func chartValueNothingSelected(_ chartView: ChartViewBase) {
        if let indexPath = selectedIndexPath {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        selectedIndexPath = nil
    }
    
}

