//
//  CurrencyCell.swift
//  BitCoinTool
//
//  Created by Pavel Bogart on 18/11/2017.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

class CurrencyCell: UITableViewCell {

    // MARK: - Type Properties
    
    static let reuseIdentifier = "CurrencyCell"
    
    // MARK: - Properties
    
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var buyPrice: UILabel!
    @IBOutlet weak var sellPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
