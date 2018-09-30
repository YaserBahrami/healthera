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
