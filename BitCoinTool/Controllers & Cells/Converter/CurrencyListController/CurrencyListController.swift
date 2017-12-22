//
//  CurrencyListController.swift
//  BitCoinTool
//
//  Created by Pavel Bogart on 21/12/2017.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

class CurrencyListController: UITableViewController {
    
    // MARK: - Properties
    
    var searchFooter: SearchFooter!
    
    var namesArray = ["Europen Euro", "New Zealand Dollar", "United States Dollar",
                      "New Taiwan Dollar", "Hong Kong Dollar", "Icelandic Krona", "Canadian Dollar",
                      "Danish Krone", "Korea Republic Won", "The British Pound", "Indian Rupee", "Swiss Franc", "Poland Zloty",
                      "Chinese Yuan", "Thailand Baht", "Chilean Peso", "Brazilian Real", "Russian Ruble", "Swedish Krona",
                      "Australian Dollar", "Singapore Dollar", "Japanese Yen"]
    
    var currencies: [Currency] = []
    var filteredCurrencies: [Currency] = []
    let searchController = UISearchController(searchResultsController: nil)
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupTableView()
        setupSearchBar()
    }
    
    // MARK: - Setup Views
    
    fileprivate func setupNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissVC))
        navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    fileprivate func setupTableView() {
        tableView?.backgroundColor = .white
        tableView.register(CurrencyListCell.self, forCellReuseIdentifier: CurrencyListCell.reuseIdentifier)
    }
    
    fileprivate func setupSearchBar() {
        // Setup The Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Currencies"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        // Setup The Search Footer
        searchFooter = SearchFooter()
        tableView.tableFooterView = searchFooter
    }
    
    fileprivate func configureCell(_ cell: CurrencyListCell, at indexPath: IndexPath) {
        let currency: Currency
        
        if isFiltering() {
            currency = filteredCurrencies[indexPath.row]
        } else {
            currency = currencies[indexPath.row]
        }
        cell.nameLabel.text = currency.name
        cell.symbolLabel.text = currency.symbol
        cell.currencyImageView.image = UIImage(named: (currency.name))
    }
    
    @objc func dismissVC() {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - TableView Methods

extension CurrencyListController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            searchFooter.setIsFilteringToShow(filteredItemCount: filteredCurrencies.count, of: currencies.count)
            return filteredCurrencies.count
        }
        //searchFooter.setNotFiltering()
        return currencies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyListCell.reuseIdentifier, for: indexPath) as! CurrencyListCell
        configureCell(cell, at: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

// MARK: - SearchBar Methods

extension CurrencyListController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    // MARK: - Private instance methods
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredCurrencies = currencies.filter({ (currency: Currency) -> Bool in
            print(currency)
            return currency.name.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
}















