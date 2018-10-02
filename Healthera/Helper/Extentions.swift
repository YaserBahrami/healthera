//
//  Extentions.swift
//  Healthera
//
//  Created by yaser on 9/30/18.
//  Copyright © 2018 Barsam. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    
    func setBottomLine(borderColor: UIColor) {
        
        self.borderStyle = UITextBorderStyle.none
        self.backgroundColor = UIColor.clear
        
        let borderLine = UIView()
        let height = 1.0
        borderLine.frame = CGRect(x: 0, y: Double(self.frame.height) - height, width: Double(self.bounds.size.width), height: height)
        borderLine.backgroundColor = borderColor
        self.addSubview(borderLine)
    }
}

extension UIButton{
    func setConrnerRadius(radius: Int){
         self.layer.cornerRadius = CGFloat(radius)
    }
}



extension Date {
    func NextDays(DayToAdd: Int)-> Date{
        return Calendar.current.date(byAdding: .day, value: DayToAdd, to: noon)!
    }
    func PreviousDays(DayToMinus: Int)-> Date{
        return Calendar.current.date(byAdding: .day, value: DayToMinus, to: noon)!
    }
   
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay)!
    }
    
    public enum MonthNameStyle {
        /// 3 letter month abbreviation of month name.
        case threeLetters
        /// 1 letter month abbreviation of month name.
        case oneLetter
        /// Full month name.
        case full
    }
    
    public func monthName(ofStyle style: MonthNameStyle = .threeLetters) -> String {
        
        let dateFormatter = DateFormatter()
        var format: String {
            switch style {
            case .oneLetter:
                return "MMMMM"
            case .threeLetters:
                return "MMM"
            case .full:
                return "MMMM"
            }
        }
        dateFormatter.setLocalizedDateFormatFromTemplate(format)
        return dateFormatter.string(from: self)
    }
}
