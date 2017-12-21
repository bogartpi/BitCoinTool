//
//  CurrencyListController.swift
//  BitCoinTool
//
//  Created by Pavel Bogart on 21/12/2017.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

class CurrencyListController: UITableViewController {
    
    var namesArray = ["European Euro", "New Zealand Dollar", "United States Dollar",
                      "New Taiwan Dollar", "Hong Kong Dollar", "Icelandic Krona", "Canadian Dollar",
                      "Danish Krone", "Korea Republic Won", "The British Pound", "Indian Rupee", "Swiss Franc", "Poland Zloty",
                      "Chinese Yuan", "Thailand Baht", "Chilean Peso", "Brazilian Real", "Russian Ruble", "Swedish Krona",
                      "Australian Dollar", "Singapore Dollar", "Japanese Yen"]
    
    var currencies: [Currency]? {
        didSet {
            print("passed")
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissVC))
        navigationController?.navigationBar.tintColor = UIColor.white
        tableView?.backgroundColor = .white
        
        tableView.register(CurrencyListCell.self, forCellReuseIdentifier: CurrencyListCell.reuseIdentifier)
    }
    
    @objc func dismissVC() {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension CurrencyListController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyListCell.reuseIdentifier, for: indexPath) as! CurrencyListCell
        let currency = currencies?[indexPath.row]
        let name = namesArray[indexPath.row]
        
        cell.longNameLabel.text = name
        cell.nameLabel.text = currency?.name
        cell.symbolLabel.text = currency?.symbol
        cell.currencyImageView.image = UIImage(named: (currency?.name)!)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

