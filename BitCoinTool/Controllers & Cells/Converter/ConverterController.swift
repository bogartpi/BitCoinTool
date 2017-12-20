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
        collectionView?.hideKeyboardWhenTappedAround()
        collectionView?.keyboardDismissMode = .interactive
        setupNavigationTitle(title: "Converter")
        setupCollectionView()
    }

    fileprivate func setupCollectionView() {
        collectionView?.backgroundColor = UIColor.customWhiteDarkColor
        collectionView?.register(ConverterCell.self, forCellWithReuseIdentifier: ConverterCell.reuseIdentifier)
    }
}

extension ConverterController: UICollectionViewDelegateFlowLayout {
   
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ConverterCell.reuseIdentifier, for: indexPath) as! ConverterCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 300)
    }
    
}
