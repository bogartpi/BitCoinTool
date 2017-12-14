//
//  CurrencyController.swift
//  BitCoinTool
//
//  Created by Pavel Bogart on 17/11/2017.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

class CurrencyController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet weak var tableView: UITableView!
    
    var refreshControl: UIRefreshControl!
    
    var currencies: [Currency]? {
        didSet {
            updateView()
        }
    }

    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fetchCurrency()
    }
    
    @objc func didRefresh(_ sender: UIRefreshControl) {
        fetchCurrency()
    }
    
    
    // MARK: - Setup View Methods
    
    private func configure(cell: CurrencyCell, at indexPath: IndexPath) {
        guard let currency = currencies?[indexPath.row] else { return }
        cell.currencyImage.image = UIImage(named: currency.name)
        cell.buyPrice.text = String(currency.buy)
        cell.sellPrice.text = String(currency.sell)
        cell.currencyLabel.text = "\(currency.name)"
    }
    
    private func setupView() {
        setupNavigationTitle(title: "Exchange Rate")
        setupTableView()
        setupRefreshControl()
    }
    
    private func setupTableView() {
        tableView.separatorInset = UIEdgeInsets.zero
    }
    
    private func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor.white
        refreshControl.addTarget(self, action: #selector(didRefresh(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    private func updateView() {
        self.tableView.reloadData()
        self.tableView.refreshControl?.endRefreshing()
        print("updated")
    }
    
    // MARK: - Fetching Data
    
    private func fetchCurrency() {
        DataManager.fetchCurrencyData(API.RateURL) { (currencies, error) in
            if let _ = error {
                if !self.checkReachability() {
                    self.showAlertWarning(title: "No Internet Connection", message: "Please check your internet connection and try again")
                } else {
                    self.showAlertWarning(title: "Ops.. Something gone wrong :(", message: "Please try again later")
                }
                self.tableView.refreshControl?.endRefreshing()
            } else {
                self.currencies = currencies
            }
        }
    }
}


// MARK: - Table View Methods

extension CurrencyController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return currencies == nil ? 0 : 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let currencies = currencies else { return 0 }
        return currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyCell.reuseIdentifier, for: indexPath) as? CurrencyCell else {
            fatalError("Unexpected Table View Cell")
        }
        configure(cell: cell, at: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
