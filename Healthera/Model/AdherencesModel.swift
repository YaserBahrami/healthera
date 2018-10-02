//
//  AdherencesModel.swift
//  Healthera
//
//  Created by yaser on 10/2/18.
//  Copyright © 2018 Barsam. All rights reserved.
//

import UIKit
import SwiftyJSON

class AdherencesModel: NSObject {
    public var action: String?
    public var note: String?
    public var alarm_time: Int?
    public var remedy_id: String?
    
    required public init?(json: JSON) {
        action = json["action"].stringValue
        note = json["note"].stringValue
        alarm_time = json["alarm_time"].intValue
        remedy_id = json["remedy_id"].stringValue
    }
    
    override public init() {
        
    }
}
