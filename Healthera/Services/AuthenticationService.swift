//
//  AuthenticationService.swift
//  Healthera
//
//  Created by yaser on 9/30/18.
//  Copyright © 2018 Barsam. All rights reserved.
//

import Foundation
import Moya
import SwiftyJSON

class AuthenticationService{
    static let shared = AuthenticationService()
    
    private init() {}
    private let provider = MoyaProvider<HealtheraService>()
    
//    func Login(username: String, password: String, callBack: @escaping (Result<[nil]>) -> Void){
//
//    }
}
