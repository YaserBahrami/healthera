//
//  NetworkProvider.swift
//  Healthera
//
//  Created by yaser on 9/30/18.
//  Copyright © 2018 Barsam. All rights reserved.
//

import Foundation
import Moya

enum HealtheraService {
    case login(userName: String, password: String)
}

var clientId = "a4c7fdd994b14c0758e91dc997426f043868d4305702f4484220df51d56497b3"

extension HealtheraService: TargetType {
    var baseURL: URL { return URL(string: "https://api.84r.co/")! }
    
    var path: String {
        switch self {
        
        case .login(_, _):
            return "tokens"
        }
    }
    var method: Moya.Method {
        switch self {
        
        case .login(_, _):
            return .post
        }
    }
    
    var task: Task {
        switch self {
       
        case .login(let userName, let password):
            return .requestParameters(parameters: ["username" : userName, "user_password": password, "device_token" : KeychainAccess.shared.getDeviceToken() ], encoding: URLEncoding.queryString)
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var headers: [String: String]? {
        var app_version = String()
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
             app_version = version
        }
        return ["Content-type" : "application/json", "Accept" : "application/json", "Token" : KeychainAccess.shared.getTokenId(), "client-id" : clientId, "app-platform" : "ios", "app-version" : app_version]
    }
}

