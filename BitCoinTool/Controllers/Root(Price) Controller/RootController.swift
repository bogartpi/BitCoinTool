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
    private let segueAddCurrencyView = "SegueAddCurrencyView"
    
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
            destination.delegate = self
            self.infoController = destination
            
        case segueCurrencyView:
            guard let destination = segue.destination as? CurrencyController else {
                fatalError("Unexpected Destination View Controller")
            }
            destination.delegate = self as? CurrencyControllerDelegate
            self.currencyController = destination
            
        case segueSettingsView:
            guard let navController = segue.destination as? UINavigationController else {
                fatalError("Unexpected Destination View Controller")
            }
            guard let destination = navController.topViewController as? SettingsController else {
                fatalError("Unexpected Destination View Controller")
            }
            destination.delegate = self as? SettingsControllerDelegate
            
        case segueAddCurrencyView:
            guard let navController = segue.destination as? UINavigationController else {
                fatalError("Unexpected Destination View Controller")
            }
            guard let destination = navController.topViewController as? AddCurrencyController else {
                fatalError("Unexpected Destination View Controller")
            }
            destination.delegate = self as? AddCurrencyControllerDelegate
            
        default:
            break
        }
    }

}

extension RootController: InfoControllerDelegate {
    
    func controllerDidTapSettingsButton(controller: InfoController) {
        performSegue(withIdentifier: segueSettingsView, sender: self)
    }
    
    func controllerDidTapAddCurrencyButton(controller: InfoController) {
        performSegue(withIdentifier: segueAddCurrencyView, sender: self)
    }
}
