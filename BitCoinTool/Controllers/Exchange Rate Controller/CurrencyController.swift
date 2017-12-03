//
//  CurrencyController.swift
//  BitCoinTool
//
//  Created by Pavel Bogart on 17/11/2017.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

class CurrencyController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var currencies = [Currency]() {
        didSet {
            print(123)
        }
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCurrencyData()
        setupNavigationTitle(title: "Exchange Rate")
    }
    
    @objc func refreshCurrencyData(_ sender: Any) {
        fetchCurrencyData()
    }
    
    private func fetchCurrencyData() {
        DataManager.fetchCurrencyData(API.RateURL) { (currenciesFetched) in
            self.currencies = currenciesFetched
            print(self.currencies)
        }
    }
    
    private func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshCurrencyData(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    private func configure(cell: CurrencyCell, at indexPath: IndexPath) {
        let currency = currencies[indexPath.row]
        cell.currencyImage.image = UIImage(named: currency.name)
        cell.buyPrice.text = String(currency.buy)
        cell.sellPrice.text = String(currency.sell)
        cell.currencyLabel.text = "\(currency.name) (\(currency.symbol))"
    }

}

// MARK: - Table View Methods

extension CurrencyController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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












