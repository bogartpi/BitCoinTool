//
//  StatViewController.swift
//  BitCoinTool
//
//  Created by Pavel Bogart on 05/12/2017.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

class StatViewController: UIViewController {
    
    // MARK: - Properties
    
    var markets = [Market]()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationTitle(title: "Stats")
        fetchMarketData()
    }
    
    // MARK: - Fetching Data
    
    private func fetchMarketData() {
        DataManager.fetchMarketData([API.MarketURL,
                                     API.TransactionURL,
                                     API.CapitalizationURL]) { (markets, error) in
            if let _ = error {
                if !self.checkReachability() {
                    self.showAlertWarning(title: "No Internet Connection",
                                          message: "Please check your internet connection and try again")
                } else {
                    self.showAlertWarning(title: "Ops.. Something gone wrong :(",
                                          message: "Please try again later")
                }
            }
            
            if let markets = markets {
                self.markets = markets
            }
        }
    }
    
}


