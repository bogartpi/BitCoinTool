//
//  InfoController.swift
//  BitCoinTool
//
//  Created by Pavel Bogart on 17/11/2017.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

protocol InfoControllerDelegate {

}


class InfoController: PriceController {

    // MARK: -
    
    var delegate: InfoControllerDelegate?
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .red 
    }

}
