//
//  ConverterView.swift
//  BitCoinTool
//
//  Created by Pavel Bogart on 15/12/2017.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

protocol ConvertCellDelegate: class {
    func didTapCurrencyButton(_ sender: ConverterCell)
    func fromBitcoinToCurrency(bitcoin amount: Double) -> Double
    func fromCurrencyToBitcoin(currency amount: Double) -> Double
}

class ConverterCell: UICollectionViewCell {
    
    var delegate: ConvertCellDelegate?
    
    static let reuseIdentifier = "ConverterCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        currencyButton.addTarget(self, action: #selector(handleCurrencyButton), for: .touchUpInside)
        btcTextField.addTarget(self, action: #selector(handleBitcoinTextField), for: .editingChanged)
        currencyTextField.addTarget(self, action: #selector(handleCurrencyTextField), for: .editingChanged)
        clearButton.addTarget(self, action: #selector(handleClearButton(_:)), for: .touchUpInside)
    }
    
    @objc func handleBitcoinTextField() {
        guard let btcAmount = btcTextField.text, let doubleValue = Double(btcAmount) else { return }
        guard let currencyAmount = delegate?.fromBitcoinToCurrency(bitcoin: doubleValue) else { return }
        currencyTextField.text = String(currencyAmount)
    }
    
    @objc func handleCurrencyTextField() {
        guard let currencyAmount = currencyTextField.text, let doubleValue = Double(currencyAmount) else { return }
        guard let bitcoinAmount = delegate?.fromCurrencyToBitcoin(currency: doubleValue) else { return }
        let behaviour = NSDecimalNumberHandler(roundingMode: .up,
                                               scale: 8, raiseOnExactness: false,
                                               raiseOnOverflow: false, raiseOnUnderflow: false,
                                               raiseOnDivideByZero: false)
        let bitcoin = NSDecimalNumber(value: bitcoinAmount).rounding(accordingToBehavior: behaviour)
        btcTextField.text = String(describing: bitcoin)
    }
    
    @objc func handleCurrencyButton(_ sender: UIButton) {
        delegate?.didTapCurrencyButton(self)
    }
    
    @objc func handleClearButton(_ sender: UIButton) {
        btcTextField.text = ""
        currencyTextField.text = ""
    }
    
    func setup() {
        backgroundColor = .clear
        setupStackViews()
    }
    
    func setupStackViews() {
        let bitcoinStackView = setStackView(items: [btcTextField, btcButton], dist: .fillProportionally, axis: .horizontal)
        let currencyStackView = setStackView(items: [currencyTextField, currencyButton], dist: .fillProportionally, axis: .horizontal)
        let buttonsStackView = setStackView(items: [clearButton], dist: .fillEqually, axis: .horizontal)
        let labelsStackView = setStackView(items: [dateLabel, bitcoinValueLabel, currencyValueLabel], dist: .fillEqually, axis: .vertical)
        
        addSubview(bitcoinStackView)
        addSubview(currencyStackView)
        addSubview(buttonsStackView)
        addSubview(labelsStackView)
        
        bitcoinStackView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 50)
        currencyStackView.anchor(top: bitcoinStackView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 50)
        buttonsStackView.anchor(top: currencyStackView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 50)
        labelsStackView.anchor(top: buttonsStackView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 16, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 80)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let btcTextField: UITextField = {
        let tf = UITextField(font: UIFont.boldSystemFont(ofSize: 30), bgColor: .white)
        return tf
    }()
    
    let btcButton: UIButton = {
        let button = UIButton(title: "BTC", bgColor: UIColor.customYellowColor, titleSize: 30)
        button.anchor(width: 120, height: 0)
        return button
    }()
    
    let currencyTextField: UITextField = {
        let tf = UITextField(font: UIFont.boldSystemFont(ofSize: 30), bgColor: .white)
        return tf
    }()
    
    let currencyButton: UIButton = {
        let button = UIButton(title: "", bgColor: UIColor.customBlueColor, titleSize: 30)
        button.anchor(width: 120, height: 0)
        return button
    }()
    
    let clearButton: UIButton = {
        let button = UIButton(title: "CLEAR", bgColor: UIColor.customRedColor, titleSize: 20)
        button.setDefaultShadow()
        return button
    }()
    
    let convertButton: UIButton = {
        let button = UIButton(title: "CONVERT", bgColor: UIColor.customGreenColor, titleSize: 25)
        button.setDefaultShadow()
        return button
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.gray
        label.text = "Average market rates on 12 Dec, 2017"
        label.textAlignment = .right
        return label
    }()
    
    let bitcoinValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.lightGray
        label.text = "1 BTC = 10,232 USD"
        label.textAlignment = .right
        return label
    }()
    
    let currencyValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.lightGray
        label.text = "1 USD = 0.00043 BTC"
        label.textAlignment = .right
        return label
    }()
}

extension UIView {
    func setStackView(items: [UIView], dist: UIStackViewDistribution, axis: UILayoutConstraintAxis) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: items)
        stackView.axis = axis
        stackView.distribution = dist
        stackView.spacing = 8
        return stackView
    }
}

extension UITextField {
    public convenience init(font: UIFont, bgColor: UIColor) {
        self.init()
        self.borderStyle = .none
        self.font = font
        self.placeholder = "0.0"
        self.textColor = UIColor.lightGray
        self.textAlignment = .right
        self.backgroundColor = bgColor
        self.setRightPaddingPoints(10)
        self.layer.cornerRadius = 3
        self.autocapitalizationType = .none
        self.tintColor = UIColor(white: 0.9, alpha: 0.8)
        self.autocorrectionType = .no
        self.clearButtonMode = .whileEditing
        self.keyboardType = UIKeyboardType.decimalPad
        self.keyboardAppearance = .light
    }
}

extension UIButton {
    public convenience init(title: String, bgColor: UIColor, titleSize: CGFloat) {
        self.init(type: .system)
        self.setTitle(title, for: .normal)
        self.setTitleColor(UIColor.white, for: .normal)
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: titleSize)
        self.backgroundColor = bgColor
        self.layer.cornerRadius = 3
    }
}
