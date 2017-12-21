//
//  ConverterController.swift
//  BitCoinTool
//
//  Created by Pavel Bogart on 16/11/2017.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

class ConverterController: UICollectionViewController, ConvertCellDelegate {
    
    // MARK: - Properties
    
    fileprivate var nodataLabel: UILabel!
    fileprivate var activityIndicatorView: UIActivityIndicatorView!
    var currencies: [Currency]? {
        didSet {
            print("set")
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
        currencyListController.currencies = currencies
        self.present(navController, animated: true, completion: nil)
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
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 300)
    }
    
}
