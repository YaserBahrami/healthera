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
    
    func Login(username: String, password: String, callBack: @escaping (Result<LoginModel>) -> Void){
        provider.request(.login(userName: username, password: password)) { result in
            switch result{
            case let .success(moyaResponse):
                let data = moyaResponse.data // Data, your JSON response is probably in here!
                let statusCode = moyaResponse.statusCode // Int - 200, 401, 500, etc
                let jsonObj = JSON(data)
                if statusCode == 200{
                    
                    let error = jsonObj["error"]["text"].stringValue
                    if error != ""{
                        print("network req failed: \(error)")
                        callBack(Result.failure(Value: error))
                        
                    }else{
                        let model = LoginModel(json: jsonObj)
                        callBack(Result.success(value: model!))
                    }
                }
            case let .failure(error):
                print("network req failed: \(error.localizedDescription)")
                callBack(Result.failure(Value: error.localizedDescription))
            }
        }

    }
    
    func logout(callBack: @escaping (_ result: Bool) -> ()){
        provider.request(.logout()) { (result) in
            switch result{
            case let .success(moyaResponse):
                let data = moyaResponse.data // Data, your JSON response is probably in here!
                let statusCode = moyaResponse.statusCode // Int - 200, 401, 500, etc
                let jsonObj = JSON(data)
                if statusCode == 200{
                    
                    let error = jsonObj["error"]["text"].stringValue
                    if error != ""{
                        print("network req failed: \(error)")
                        callBack(false)
                        
                    }else{
                        callBack(true)
                    }
                }
            case let .failure(error):
                print("network req failed: \(error.localizedDescription)")
                callBack(false)
            }
        }
    }
}
