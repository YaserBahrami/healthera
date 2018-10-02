//
//  AdherencesService.swift
//  Healthera
//
//  Created by yaser on 10/2/18.
//  Copyright © 2018 Barsam. All rights reserved.
//

import Foundation
import Moya
import SwiftyJSON

class AdherencesService{
    static let shared = AdherencesService()
    
    private init() {}
    private let provider = MoyaProvider<HealtheraService>()
    
    func getAdherences(start: Int, end: Int, callBack: @escaping (Result<[AdherencesModel]>) -> Void){
        provider.request(.getAdherences(start: start, end: end)) { (result) in
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
//                        print(jsonObj)
                        
                        var objects = [AdherencesModel]()
                        let items = jsonObj["data"]
                        print(items)
                        if items.count > 0{
                            for index in 0...(items.count-1){
                                let temp = AdherencesModel(json: items[index])!
                                objects.append(temp)
                            }
                        }
                        
                        callBack(Result.success(value: objects))
                    }
                }
            case let .failure(error):
                print("network req failed: \(error.localizedDescription)")
                callBack(Result.failure(Value: error.localizedDescription))
            }
        }
    }
    
    func getSpecificRemedy(pId: String, rId: String, callBack: @escaping (Result<RemedyModel>) -> Void){
        provider.request(.getRemedy(patientId: pId, remedyId: rId)) { (result) in
            switch result{
            case let .success(moyaResponse):
                let data = moyaResponse.data // Data, your JSON response is probably in here!
                let statusCode = moyaResponse.statusCode // Int - 200, 401, 500, etc
                var jsonObj = JSON(data)
                if statusCode == 200{
                    
                    let error = jsonObj["error"]["text"].stringValue
                    if error != ""{
                        print("network req failed: \(error)")
                        callBack(Result.failure(Value: error))
                        
                    }else{
                        jsonObj = jsonObj["data"][0]
                        let model = RemedyModel(json: jsonObj)
                        print(model?.medicine_name)
                        print(model?.medicine_type)
                        print("////")
                        callBack(Result.success(value: model!))
                    }
                }
            case let .failure(error):
                print("network req failed: \(error.localizedDescription)")
                callBack(Result.failure(Value: error.localizedDescription))
            }
        }
    }
    
    
}
