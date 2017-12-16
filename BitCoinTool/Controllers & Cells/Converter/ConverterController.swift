//
//  ConverterController.swift
//  BitCoinTool
//
//  Created by Pavel Bogart on 16/11/2017.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

class ConverterController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        setupNavigationTitle(title: "Converter")
    }

}
