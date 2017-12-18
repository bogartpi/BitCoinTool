//
//  MainTabBarController.swift
//  BitCoinTool
//
//  Created by Pavel Bogart on 15/12/2017.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupControllers()
    }
    
    func setupTabBar() {
        tabBar.barTintColor = .white
        tabBar.alpha = 1
        view.backgroundColor = .white
    }
    
    func setupControllers() {
        
        // Controllers
        
        let rateController = RateController(collectionViewLayout: UICollectionViewFlowLayout())
        let converterController = ConverterController(collectionViewLayout: UICollectionViewFlowLayout())
        let statController = StatViewController(collectionViewLayout: UICollectionViewFlowLayout())
        
        // Rate
        let rate = constructController(rootController: rateController,
                                       selectedImage: #imageLiteral(resourceName: "rate"),
                                       unselectedImage: #imageLiteral(resourceName: "rate"))
        // Converter
        let converter = constructController(rootController: converterController,
                                                 selectedImage: #imageLiteral(resourceName: "converter"),
                                                 unselectedImage: #imageLiteral(resourceName: "converter"))
        // Stat
        let stat = constructController(rootController: statController,
                                                 selectedImage: #imageLiteral(resourceName: "stat"),
                                                 unselectedImage: #imageLiteral(resourceName: "stat"))
        
        viewControllers = [rate, stat, converter]
        
        // Modify TabBar Items Insets
        
        guard let items = tabBar.items else { return }
        
        for item in items {
            item.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0)
        }
    }
    
}

extension MainTabBarController {
    
    fileprivate func constructController(rootController: UIViewController = UIViewController(),
                                         selectedImage: UIImage,
                                         unselectedImage: UIImage) -> UINavigationController {
        let viewController = rootController
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image = selectedImage.withRenderingMode(.alwaysOriginal)
        navController.tabBarItem.selectedImage = unselectedImage.withRenderingMode(.alwaysTemplate)
        return navController
    }
    
}

