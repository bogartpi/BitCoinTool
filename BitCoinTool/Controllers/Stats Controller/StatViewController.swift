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
    
    // MARK: - Properties
    
    var markets = [Market]()
    
    var topCarouselCollectionView: ScalingCarouselView = {
        let frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        let scalingCarousel = ScalingCarouselView(withFrame: frame, andInset: 25)
        scalingCarousel.backgroundColor = .clear
        return scalingCarousel
    }()
    
    var bottomCarouselCollectionView: ScalingCarouselView = {
        let frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        let scalingCarousel = ScalingCarouselView(withFrame: frame, andInset: 25)
        scalingCarousel.backgroundColor = .clear
        return scalingCarousel
    }()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationTitle(title: "Stats")
        setupCollectionViews()
        fetchMarketData()
    }
    
    // MARK: - Setup Collection Views
    
    func setupCollectionViews() {
        topCarouselCollectionView.register(CarouselCell.self, forCellWithReuseIdentifier: CarouselCell.reuseIdentifier)
        topCarouselCollectionView.delegate = self
        topCarouselCollectionView.dataSource = self
        topCarouselCollectionView.showsHorizontalScrollIndicator = false

        bottomCarouselCollectionView.register(CarouselCell.self, forCellWithReuseIdentifier: CarouselCell.reuseIdentifier)
        bottomCarouselCollectionView.delegate = self
        bottomCarouselCollectionView.dataSource = self
        bottomCarouselCollectionView.showsHorizontalScrollIndicator = false
        
        let stackView = UIStackView(arrangedSubviews: [topCarouselCollectionView,
                                                       bottomCarouselCollectionView])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        
        view.addSubview(stackView)
        stackView.anchor(top: view.topAnchor,
                         left: view.leftAnchor,
                         bottom: view.safeBottomAnchor,
                         right: view.rightAnchor,
                         paddingTop: 10, paddingLeft: 10,
                         paddingBottom: 10, paddingRight: 10)
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

// MARK: - Collection View Methods

extension StatViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == topCarouselCollectionView {
            return markets.count - 1
        }
        if collectionView == bottomCarouselCollectionView {
            return markets.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let market = markets[indexPath.item]
        guard let marketValues = market.values.last else { fatalError() }
        
        // Populate topCollectionView
        if collectionView == topCarouselCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselCell.reuseIdentifier,
                                                          for: indexPath)
            if let carouselCell = cell as? CarouselCell {
                carouselCell.marketName.text = market.name
                carouselCell.marketValue.text = String(marketValues.valueY)
                carouselCell.lastUpdated.text = String("Last updated on \(marketValues.dateX)")
                carouselCell.marketDescription.text = market.description
                return carouselCell
            }
            return cell
        }
        
        // Populate bottom collectionView
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselCell.reuseIdentifier,
                                                      for: indexPath)
        if let carouselCell = cell as? CarouselCell {
            carouselCell.marketName.text = market.name
            carouselCell.marketValue.text = String(marketValues.valueY)
            carouselCell.lastUpdated.text = String("Last updated on \(marketValues.dateX)")
            carouselCell.marketDescription.text = market.description
            return carouselCell
        }
        return cell
    
    }

}
