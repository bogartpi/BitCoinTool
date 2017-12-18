//
//  StatViewController.swift
//  BitCoinTool
//
//  Created by Pavel Bogart on 05/12/2017.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

class StatViewController: UICollectionViewController {
    
    // MARK: - Properties
    
    var markets: [Market]? {
        didSet {
            self.collectionView?.reloadData()
        }
    }
    
    var statMenuTitles: [StatMenuTitles] = [.price, .transactions, .capitalization]
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationTitle(title: "Stats")
        setupCollectionView()
        fetchMarketData()
        collectionView?.backgroundColor = UIColor.customWhitecolor
    }
    
    // MARK: - Setup Views
    
    private func setupCollectionView() {
        collectionView?.backgroundColor = .white
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.register(StatCell.self, forCellWithReuseIdentifier: StatCell.reuseIdentifier)
    }
    
    // MARK: - Fetching Data
    
    private func fetchMarketData() {
        DispatchQueue.main.async {
            DataManager.fetchMarketData([API.MarketURL, API.TransactionURL, API.CapitalizationURL]) { (markets, error) in
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
                    var values: [Value] = []
                    
                    self.markets = markets
                    
                    values = markets[0].values
                }
            }
        }
    }
    
    private func showStatDetailsController() {
        let controller = StatDetailsController()
        self.present(controller, animated: true, completion: nil)
    }
}

extension StatViewController: UICollectionViewDelegateFlowLayout {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return markets == nil ? 0 : 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = markets?.count else { return 0 }
        return count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StatCell.reuseIdentifier, for: indexPath) as! StatCell
        var valuesArray: [Value] = []
        
        if let market = markets?[indexPath.item] {
            
            valuesArray = market.values
            let lastTwoValues = valuesArray.suffix(2)
            let result = calculateChange(values: lastTwoValues)
            
            print("\n\(lastTwoValues)")
            print("\n\(result)")
            if result.positive {
                cell.arrowImageView.image = UIImage(named: "up-arrow")
            } else {
                cell.arrowImageView.image = UIImage(named: "down-arrow")
            }
            cell.valueChangesLabel.text = String(result.change)
            cell.marketName.text = statMenuTitles[indexPath.item].rawValue
            cell.marketDescription.text = market.description
            if let lastDateUpdated = market.values.last?.dateX,
                let lastValueDouble = market.values.last?.valueY {
                let lastValueInt = Int(lastValueDouble)
                cell.lastUpdated.text = String(describing: lastDateUpdated)
                cell.marketValue.text = convertToLargeNumber(number: lastValueInt)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return  CGSize(width: view.frame.width - 20, height: 200)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showStatDetailsController()
    }
}


