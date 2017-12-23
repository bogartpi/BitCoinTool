//
//  ConverterController.swift
//  BitCoinTool
//
//  Created by Pavel Bogart on 16/11/2017.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import Foundation
import UIKit

extension ConverterController: ChangeCurrencyDelegate {
    
    // MARK: - Conform to Protocol
    
    func didPickNewCurrency(currency: Currency) {
        self.selectedCurrency = currency
        print(currency)
    }
}

class ConverterController: UICollectionViewController, ConvertCellDelegate {
    
    // MARK: - Properties
    
    fileprivate var nodataLabel: UILabel!
    fileprivate var activityIndicatorView: UIActivityIndicatorView!
    fileprivate var currencyIsUpdated: Bool = false
    
    var currencies: [Currency]?
    var selectedCurrency: Currency? {
        didSet {
            currencyIsUpdated = true
            collectionView?.reloadData()
        }
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        fetchCurrency()
    }

    // MARK: - Setup Views
    
    fileprivate func setup() {
        setupNavigationTitle(title: "Converter")
        setupCollectionView()
        setupViews()
    }
    
    fileprivate func setupViews() {
        self.nodataLabel = setNodataLabel()
        self.activityIndicatorView = setupActivityIndicator()
    }
    
    fileprivate func setupCollectionView() {
        collectionView?.backgroundView = self.activityIndicatorView
        collectionView?.hideKeyboardWhenTappedAround()
        collectionView?.keyboardDismissMode = .interactive
        collectionView?.backgroundColor = UIColor.customWhiteDarkColor
        collectionView?.register(ConverterCell.self, forCellWithReuseIdentifier: ConverterCell.reuseIdentifier)
    }
    
    fileprivate func configureCell(_ cell: ConverterCell, at indexPath: IndexPath, currency: Currency) {
        let amountOfBitcoin = calculateCurrency(currency: currency)
        let convertedCurrencyToDecimal = convertToLargeNumber(number: Int(currency.buy))
        cell.dateLabel.text = "Average market rates on \(getCurrentTime())"
        cell.bitcoinValueLabel.text = "1 BTC = \(convertedCurrencyToDecimal) \(currency.name)"
        cell.currencyValueLabel.text = "1 \(currency.name) = \(amountOfBitcoin) BTC"
        cell.currencyButton.setTitle(currency.name, for: .normal)
    }
    
    // MARK: - Fetching Data
    
    fileprivate func fetchCurrency() {
        DataManager.fetchCurrencyData(API.RateURL) { (currencies, error) in
            if let _ = error {
                if !self.checkReachability() {
                    self.showAlertWarning(title: "No Internet Connection", message: "Please check your internet connection and try again")
                    self.activityIndicatorView.stopAnimating()
                    self.collectionView?.backgroundView = self.nodataLabel
                } else {
                    self.showAlertWarning(title: "Ops.. Something gone wrong :(", message: "Please try again later")
                    self.activityIndicatorView.stopAnimating()
                    self.collectionView?.backgroundView = self.nodataLabel
                }
            } else {
                self.currencies = currencies
                self.activityIndicatorView.stopAnimating()
                self.collectionView?.reloadData()
            }
        }
    }
    
    // MARK: - Handle Pressed Buttons
    
    @objc func didTapCurrencyButton(_ sender: ConverterCell) {
        let currencyListController = CurrencyListController()
        let navController = UINavigationController(rootViewController: currencyListController)
        currencyListController.changeCurrencyDelegate = self
        if let currencies = currencies {
            currencyListController.currencies = currencies
            self.present(navController, animated: true, completion: nil)
        }
    }
    
    // MARK: - Business Logic
    
    func calculateCurrency(currency: Currency) -> NSDecimalNumber {
        let x = Double(1.0000 / currency.buy)
        let behaviour = NSDecimalNumberHandler(roundingMode: .up,
                                               scale: 8, raiseOnExactness: false,
                                               raiseOnOverflow: false, raiseOnUnderflow: false,
                                               raiseOnDivideByZero: false)
        return NSDecimalNumber(value: x).rounding(accordingToBehavior: behaviour)
    }
    
}

// MARK: - Collection View Methods

extension ConverterController: UICollectionViewDelegateFlowLayout {
   
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ConverterCell.reuseIdentifier, for: indexPath) as! ConverterCell
        cell.delegate = self
        if !currencyIsUpdated {
            if let prevCurrency = currencies?[indexPath.row] {
                configureCell(cell, at: indexPath, currency: prevCurrency)
            }
        } else if currencyIsUpdated {
            if let currency = selectedCurrency {
                configureCell(cell, at: indexPath, currency: currency)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 300)
    }

}

