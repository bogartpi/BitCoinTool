//
//  StatViewController.swift
//  BitCoinTool
//
//  Created by Pavel Bogart on 05/12/2017.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

class StatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var markets = [Market]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationTitle(title: "Stats")
        setupTableView()
        fetchMarketData()
    }
    
    private func fetchMarketData() {
        DataManager.fetchMarketData([API.MarketURL, API.TransactionURL, API.CapitalizationURL]) { (markets, error) in
            if let _ = error {
                if !self.checkReachability() {
                    self.showAlertWarning(title: "No Internet Connection", message: "Please check your internet connection and try again")
                } else {
                    self.showAlertWarning(title: "Ops.. Something gone wrong :(", message: "Please try again later")
                }
            }
            
            if let markets = markets {
                self.markets = markets
            }
        }
    }
    
}

// MARK: - Setup Views

extension StatViewController {
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(StatCell.self, forCellReuseIdentifier: StatCell.reuseIdentifier)
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
    }
    
}

// MARK: - Table View Methods

extension StatViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return markets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StatCell.reuseIdentifier, for: indexPath) as! StatCell
        let market = markets[indexPath.row]
        cell.chartName.text = market.name
        cell.chartDescription.text = market.description
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}
