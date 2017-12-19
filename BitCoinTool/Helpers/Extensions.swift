//
//  Extensions.swift
//  BitCoinTool
//
//  Created by Pavel Bogart on 04/12/2017.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import Foundation
import UIKit
import Charts

public extension UIViewController {
    func setupNavigationTitle(title: String) {
        navigationItem.title = title
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedStringKey.foregroundColor: UIColor.customWhitecolor]
        
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
            self.navigationItem.largeTitleDisplayMode = .always
            self.navigationController?.navigationBar.largeTitleTextAttributes =
                [NSAttributedStringKey.foregroundColor: UIColor.customWhitecolor]
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
    
    public func setDefaultShadowForCell(contentView: UIView) {
        contentView.layer.cornerRadius = 2.0
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.layer.shadowRadius = 1.5
        self.layer.shadowOpacity = 1.0
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
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

extension UIViewController {
    
    func convertToLargeNumber(number: Int) ->  String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        guard let formattedNumber = numberFormatter.string(from: NSNumber(value: number)) else { return ""}
        return formattedNumber
    }

    func calculateChange(values: ArraySlice<Value>) -> (change: Double, positive: Bool) {
        var positiveResult: Bool!
        
        guard let firstValue = values.first?.valueY else { fatalError("No value") }
        guard let lastValue = values.last?.valueY else { fatalError("No value") }
        
        var change = ((lastValue - firstValue) * 100 / lastValue)
        
        if change > 0 {
            positiveResult = true
        } else {
            positiveResult = false
        }
        
        return (change.roundToPlaces(places: 2), positiveResult)
    }
    
}

public extension Double {
    
    mutating func roundToPlaces(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return Darwin.round(self * divisor) / divisor
    }
    
}

public extension UIViewController {
    func convertToDate(value: Int, style: DateFormatter.Style) -> String {
        let date = NSDate(timeIntervalSince1970: TimeInterval(value))
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = style //Set date style
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: date as Date)
    }
}

public extension UIViewController {
    
    func addLineChartView() -> LineChartView {
        let chart = LineChartView()
        chart.noDataText = ""
        chart.dragEnabled = false
        chart.setScaleEnabled(false)
        chart.chartDescription?.enabled = false
        chart.maxHighlightDistance = 300
        
        chart.xAxis.enabled = false
        
        let yAxis = chart.leftAxis
        yAxis.drawAxisLineEnabled = false
        yAxis.enabled = false
        
        chart.rightAxis.enabled = false
        chart.legend.enabled = false
        
        chart.translatesAutoresizingMaskIntoConstraints = false
        return chart
    }
    
    func addReferenceLabel(text: String, color: UIColor, view: UIView? = nil) -> UILabel {
        
        let label = UILabel()
        label.text = text
        label.textColor = color
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 11)
        
        self.view.addSubview(label)
        label.anchor(top: view?.bottomAnchor, left: view?.leftAnchor, bottom: nil, right: view?.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)

        return label
    }
    
}







