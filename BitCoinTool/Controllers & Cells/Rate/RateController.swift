//
//  CurrencyController.swift
//  BitCoinTool
//
//  Created by Pavel Bogart on 17/11/2017.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

class RateController: UICollectionViewController {

    // MARK: - Properties
    
    var currencies: [Currency]? {
        didSet {
            print("set")
        }
    }

    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationTitle(title: "Rate")
        collectionView?.backgroundColor = UIColor.customWhiteDarkColor
        collectionView?.register(RateCell.self, forCellWithReuseIdentifier: RateCell.reuseIdentifier)
        fetchCurrency()
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
            } else {
                self.currencies = currencies
            }
        }
    }
    
    // MARK: - Setup View Methods

    private func configure(cell: RateCell, at indexPath: IndexPath) {
        guard let currency = currencies?[indexPath.row] else { return }
        cell.countryImage.image = UIImage(named: currency.name)
        cell.buyValueLabel.text = convertToLargeNumber(number: Int(currency.buy))
        cell.sellValueLabel.text = convertToLargeNumber(number: Int(currency.sell))
        cell.currencyLabel.text = "\(currency.name)"
    }

}

// MARK: - Collection View Methods

extension RateController: UICollectionViewDelegateFlowLayout {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return currencies == nil ? 0 : 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let currencies = currencies else { return 0 }
        print(currencies.count)
        return currencies.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RateCell.reuseIdentifier, for: indexPath) as? RateCell else {
            fatalError("Unexpected Table View Cell")
        }
        
        configure(cell: cell, at: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 20, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
    }
    
}

