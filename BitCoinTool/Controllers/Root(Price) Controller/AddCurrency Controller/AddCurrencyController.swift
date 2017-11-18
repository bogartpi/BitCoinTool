//
//  AddCurrencyController.swift
//  BitCoinTool
//
//  Created by Pavel Bogart on 18/11/2017.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

protocol AddCurrencyControllerDelegate {
    
}

class AddCurrencyController: UIViewController {

    var delegate: AddCurrencyControllerDelegate?
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .green
    }

}
