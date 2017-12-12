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
    
    private let prevButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("PREV", for: .normal)
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("NEXT", for: .normal)
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = 3
        pc.pageIndicatorTintColor = .gray
        pc.currentPageIndicatorTintColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        return pc
    }()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupNavigationTitle(title: "Stats")
        setupBottomControls()
        fetchMarketData()
        setupActionsForButtons()
    }
    
    // MARK: - Setup Views
    
    private func setupCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(StatCell.self, forCellWithReuseIdentifier: StatCell.reuseIdentifier)
        collectionView.isPagingEnabled = true
    }
    
    private func setupBottomControls() {
        let bottomStackView = UIStackView(arrangedSubviews: [prevButton, pageControl, nextButton])
        bottomStackView.axis = .horizontal
        bottomStackView.distribution = .fillEqually
        bottomStackView.spacing = 10
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(bottomStackView)
        
        NSLayoutConstraint.activate([
            bottomStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomStackView.heightAnchor.constraint(equalToConstant: 50)
            ])
    }
    
    // MARK: Setup Actions
    
    private func setupActionsForButtons() {
        prevButton.addTarget(self, action: #selector(previousPressed(_:)), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextPressed(_:)), for: .touchUpInside)
    }
    
    @objc private func previousPressed(_ sender: UIButton) {
        let nextIndex = max(pageControl.currentPage - 1, 0)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    @objc private func nextPressed(_ sender: UIButton) {
        let nextIndex = min(pageControl.currentPage + 1, 2)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
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
        pageControl.currentPage = currentPageIndex
    }
}

class StatCell: UICollectionViewCell {
    
    static let reuseIdentifier = "statCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    func setup() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



















