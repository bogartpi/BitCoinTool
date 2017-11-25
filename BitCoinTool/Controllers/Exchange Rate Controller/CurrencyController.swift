//
//  CurrencyController.swift
//  BitCoinTool
//
//  Created by Pavel Bogart on 17/11/2017.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

class CurrencyController: MainCurrencyController {

    @IBOutlet weak var tableView: UITableView!
    
    var currencyName: [String] = []
    var currenciesArray: [Currency] = []
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchCurrency()
    }
    
    func fetchCurrency() {
        guard let urlString = API.BaseURL.absoluteString else { return }
        guard let url = URL(string: urlString) else { return }
        let jsonData = try! Data(contentsOf: url)
        let decoder = JSONDecoder()
        do {
            let currencies = try decoder.decode([String: Currency].self, from: jsonData)
            for currency in currencies {
                self.currencyName.append(currency.key)
                self.currenciesArray.append(currency.value)
            }
        } catch let err {
            print(err.localizedDescription)
        }
    }

}

extension CurrencyController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencyName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyCell.reuseIdentifier, for: indexPath) as? CurrencyCell else {
            fatalError("Unexpected Table View Cell")
        }
        
        cell.currencyLabel.text = currencyName[indexPath.row]

        
        let currency = currenciesArray[indexPath.row]
        cell.buyPrice.text = String(currency.buy)
        cell.sellPrice.text = String(currency.sell)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}












