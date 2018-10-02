//
//  RemedyModel.swift
//  Healthera
//
//  Created by yaser on 10/2/18.
//  Copyright © 2018 Barsam. All rights reserved.
//

import UIKit
import SwiftyJSON

class RemedyModel: NSObject {
    public var medicine_type: String?
    public var medicine_name: String?
    
    required public init?(json: JSON) {
        medicine_type = json["medicine_type"].stringValue
        medicine_name = json["medicine_name"].stringValue
    }
    
    override public init() {
        
    }
}
