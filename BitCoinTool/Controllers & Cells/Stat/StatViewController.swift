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
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupNavigationTitle(title: "Stats")
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
                    self.markets = markets
                }
            }
        }
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
        if let market = markets?[indexPath.item] {
            cell.marketName.text = market.name
            cell.marketDescription.text = market.description
            cell.lastUpdated.text = "Last updated on 12 December 21:00 PM"
            cell.marketValue.text = "$ 16599"
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return  CGSize(width: view.frame.width - 20, height: 200)
    }
}


