//
//  InfoController.swift
//  BitCoinTool
//
//  Created by Pavel Bogart on 17/11/2017.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

protocol InfoControllerDelegate {
    func controllerDidTapAddCurrencyButton(controller: InfoController)
    func controllerDidTapSettingsButton(controller: InfoController)
}

class InfoController: PriceController {
    
    var delegate: InfoControllerDelegate?
    
    // MARK: - Properties
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeUpdateLabel: UILabel!
    
    // MARK: - Actions
    
    @IBAction func didTapSettingsButton(_ sender: UIButton) {
        delegate?.controllerDidTapSettingsButton(controller: self)
    }
    
    @IBAction func didTapAddCurrencyButton(_ sender: UIButton) {
        delegate?.controllerDidTapAddCurrencyButton(controller: self)
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

         
    }

}
