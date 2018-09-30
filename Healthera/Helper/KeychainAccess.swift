//
//  KeychainAccess.swift
//  Healthera
//
//  Created by yaser on 9/30/18.
//  Copyright © 2018 Barsam. All rights reserved.
//

import KeychainSwift

class KeychainAccess{
    
    static let shared = KeychainAccess()
    private init() {}
    
    private var token_id = "tokenId"
    private var userId = "userId"
    private var deviceToken = "deviceToken"
    private func setKeychain(key: String, value: String){
        let keychain = KeychainSwift()
        keychain.set(value, forKey: key)
    }
    private func getKeychain(key: String) -> String{
        let keychain = KeychainSwift()
        if keychain.get(key) != nil{
            return keychain.get(key)!
        }else{
            return ""
        }
    }
    
    func clearKeychains(){
        let keychain = KeychainSwift()
        keychain.clear()
    }
    
    func setTokenIdOnKeychain(token: String){
        setKeychain(key: token_id, value: token)
    }
    
    func getTokenId() -> String{
        return getKeychain(key: token_id)
    }
    
    func setUserId(user_id: String){
        setKeychain(key: userId, value: user_id)
    }
    func getUserId() -> String{
        return getKeychain(key: userId)
    }
    
    func setDeviceToken(device_token: String){
        setKeychain(key: deviceToken, value: device_token)
    }
    func getDeviceToken()->String{
        return getKeychain(key: deviceToken)
    }
    
}
