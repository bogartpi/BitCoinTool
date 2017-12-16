//
//  Extensions.swift
//  BitCoinTool
//
//  Created by Pavel Bogart on 04/12/2017.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import Foundation
import UIKit

public extension UIViewController {
    func setupNavigationTitle(title: String) {
        navigationItem.title = title
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedStringKey.foregroundColor: UIColor.darkGray]
        
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
            self.navigationItem.largeTitleDisplayMode = .always
            self.navigationController?.navigationBar.largeTitleTextAttributes =
                [NSAttributedStringKey.foregroundColor: UIColor.darkGray]
        }
    }
}

public extension UIView {
    public func setDefaultShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 2.0
        self.clipsToBounds = false
        self.layer.masksToBounds = false
    }
}

public extension UIViewController {
    func checkReachability() -> Bool {
        if currentReachabilityStatus == .reachableViaWiFi || currentReachabilityStatus == .reachableViaWWAN{
            print("connected")
            return true
        } else {
            print("not connected")
            return false
        }
    }
}

public extension UIViewController {
    func showAlertWarning(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .cancel)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true)
    }
}
