//
//  CurrencyController.swift
//  BitCoinTool
//
//  Created by Pavel Bogart on 17/11/2017.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

protocol CurrencyControllerDelegate {
    
}

class CurrencyController: PriceController {

    @IBOutlet weak var tableView: UITableView!
    
    var delegate: CurrencyControllerDelegate?
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

extension CurrencyController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyCell.reuseIdentifier, for: indexPath) as? CurrencyCell else {
            fatalError("Unexpected Table View Cell")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}












