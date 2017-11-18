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
    
    @IBOutlet weak var shortCurrencyLabel: UILabel!
    @IBOutlet weak var longCurrencyLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var changePriceLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
