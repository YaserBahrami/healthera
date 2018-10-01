//
//  LoginModel.swift
//  Healthera
//
//  Created by yaser on 10/1/18.
//  Copyright © 2018 Barsam. All rights reserved.
//

import UIKit
import SwiftyJSON

class LoginModel: NSObject {
    public var token: String?
    public var user_id: String?
    
    required public init?(json: JSON) {
        token = json["data"][0]["token"].stringValue
        user_id = json["aux"]["tokenPayload"]["user_id"].stringValue
    }
    
    override public init() {
        
    }
}
