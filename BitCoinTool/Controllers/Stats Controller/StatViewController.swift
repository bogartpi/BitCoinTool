//
//  StatViewController.swift
//  BitCoinTool
//
//  Created by Pavel Bogart on 05/12/2017.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit
import ScalingCarousel

class StatViewController: UIViewController {
    
    var markets = [Market]()
    
    var carouselCollectionView: ScalingCarouselView = {
        let frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        let scalingCarousel = ScalingCarouselView(withFrame: frame, andInset: 25)
        scalingCarousel.backgroundColor = .clear
        return scalingCarousel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationTitle(title: "Stats")
        setupCollectionView()
        fetchMarketData()
    }
    
    private func fetchMarketData() {
        DataManager.fetchMarketData([API.MarketURL, API.TransactionURL, API.CapitalizationURL]) { (markets, error) in
            if let _ = error {
                if !self.checkReachability() {
                    self.showAlertWarning(title: "No Internet Connection", message: "Please check your internet connection and try again")
                } else {
                    self.showAlertWarning(title: "Ops.. Something gone wrong :(", message: "Please try again later")
                }
            }
            
            if let markets = markets {
                self.markets = markets
            }
        }
    }
    
}

// MARK: - Setup Views

extension StatViewController {
    
    func setupCollectionView() {
        carouselCollectionView.register(CarouselCell.self, forCellWithReuseIdentifier: CarouselCell.reuseIdentifier)
        carouselCollectionView.delegate = self
        carouselCollectionView.dataSource = self
        carouselCollectionView.showsHorizontalScrollIndicator = false
        view.addSubview(carouselCollectionView)
        carouselCollectionView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.safeBottomAnchor, right: view.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 10, paddingRight: 0)
    }
    
}

// MARK: - Collection View Methods

extension StatViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return markets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselCell.reuseIdentifier, for: indexPath)
        
        if let carouselCell = cell as? CarouselCell {
            // display data
            
        }
        
        return cell
    }

}
