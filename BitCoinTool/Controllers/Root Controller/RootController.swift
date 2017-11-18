//
//
//  BitCoinTool
//
//  Created by Pavel Bogart on 16/11/2017.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

class RootController: UIViewController {

    // MARK: - Constants
    
    private let segueInfoView = "SegueInfoView"
    private let segueCurrencyView = "SegueCurrencyView"
    private let segueSettingsView = "SegueSettingsView"
    private let segueAddCurrencyView = "SegueAddCurrency"
    
    // MARK: - Properties
    
    @IBOutlet private var infoController: InfoController!
    @IBOutlet private var currencyController: CurrencyController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
        case segueInfoView:
            guard let destination = segue.destination as? InfoController else {
                fatalError("Unexpected Destination View Controller")
            }
            // Configure Destination
            destination.delegate = self as? InfoControllerDelegate
            // Update InfoController
            self.infoController = destination
            
        case segueCurrencyView:
            guard let destination = segue.destination as? CurrencyController else {
                fatalError("Unexpected Destination View Controller")
            }
            // Configure Destination
            destination.delegate = self as? CurrencyControllerDelegate
            // Update CurrencyController
            self.currencyController = destination
            
        default: break
        }
    }

}
