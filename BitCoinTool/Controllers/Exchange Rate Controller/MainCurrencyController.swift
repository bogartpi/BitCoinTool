//
//  PriceController.swift
//  BitCoinTool
//
//  Created by Pavel Bogart on 18/11/2017.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

class MainCurrencyController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var currencyContainerView: UIView!
    
    // MARK: - Properties
    
    
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setupView()
        setupNavigationTitle()
    }
    
    func setupNavigationTitle() {
        // remove gap between tableview and navbar
        // edgesForExtendedLayout = []
        
        navigationItem.title = "Exchange Rate"
        navigationController?.navigationBar.isTranslucent = false 
        navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedStringKey.foregroundColor: UIColor.white]
        
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
            self.navigationItem.largeTitleDisplayMode = .always
            self.navigationController?.navigationBar.largeTitleTextAttributes =
                [NSAttributedStringKey.foregroundColor: UIColor.white]
        }
    }
    
    // MARK: - View Methods
    
    func setupView() {
        // Configure Message Label
        messageLabel.isHidden = true
        
        // Configure Currency Container View
        currencyContainerView.isHidden = true
        
        // Configure Activity Indicator View
        activityIndicatorView.startAnimating()
        activityIndicatorView.hidesWhenStopped = true
    }
    
    func updateView() {
        
    }
    
    // MARK: - Public Interface
    
    func reloadData() {
        
    }

}
