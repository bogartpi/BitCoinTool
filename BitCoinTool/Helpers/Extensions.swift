//
//  Extensions.swift
//  BitCoinTool
//
//  Created by Pavel Bogart on 04/12/2017.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func setupNavigationTitle(title: String) {
        navigationItem.title = title
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
    
}
