//
//  PriceController.swift
//  BitCoinTool
//
//  Created by Pavel Bogart on 18/11/2017.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

class PriceController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var currencyContainerView: UIView!
    
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
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
