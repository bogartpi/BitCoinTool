//
//  StatViewController.swift
//  BitCoinTool
//
//  Created by Pavel Bogart on 05/12/2017.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

class StatViewController: UIViewController {
    
    // MARK: - Properties
    
    var markets = [Market]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupNavigationTitle(title: "Stats")
        fetchMarketData()
    }
    
    // MARK: - Setup Views
    
    func setupCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(StatCell.self, forCellWithReuseIdentifier: StatCell.reuseIdentifier)
        collectionView.isPagingEnabled = true
    }
    
    // MARK: - Fetching Data
    
    private func fetchMarketData() {
        DataManager.fetchMarketData([API.MarketURL,
                                     API.TransactionURL,
                                     API.CapitalizationURL]) { (markets, error) in
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

extension StatViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return markets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StatCell.reuseIdentifier, for: indexPath) as! StatCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let currentPageIndex = Int(targetContentOffset.pointee.x / view.frame.width)
        print(currentPageIndex)
    }
}

class StatCell: UICollectionViewCell {
    
    static let reuseIdentifier = "statCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    func setup() {
        backgroundColor = .red
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



















