//
//  ConverterController.swift
//  BitCoinTool
//
//  Created by Pavel Bogart on 16/11/2017.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import Foundation
import UIKit

class ConverterController: UICollectionViewController, ConvertCellDelegate {
    
    // MARK: - Properties
    
    fileprivate var nodataLabel: UILabel!
    fileprivate var activityIndicatorView: UIActivityIndicatorView!
    var currencies: [Currency]? {
        didSet {
            
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
    
    // MARK: Handle Pressed Buttons
    
    @objc func didTapCurrencyButton(_ sender: ConverterCell) {
        let currencyListController = CurrencyListController()
        let navController = UINavigationController(rootViewController: currencyListController)
        currencyListController.currencies = currencies!
        self.present(navController, animated: true, completion: nil)
    }

    func getCurrentTime() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        let localDate = dateFormatter.string(from: date)
        print(localDate)
        return localDate
    }
    
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
        let currency = currencies?[indexPath.row]
        
        if let currency = currency {
            let amountOfBitcoin = calculateCurrency(currency: currency)
            let convertedCurrencyToDecimal = convertToLargeNumber(number: Int(currency.buy))
            cell.dateLabel.text = "Average market rates on \(getCurrentTime())"
            cell.bitcoinValueLabel.text = "1 BTC = \(convertedCurrencyToDecimal) \(currency.name)"
            cell.currencyValueLabel.text = "1 \(currency.name) = \(amountOfBitcoin) BTC"
            cell.currencyButton.setTitle(currency.name, for: .normal)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 300)
    }
    
}

