//
//  Result.swift
//  Healthera
//
//  Created by yaser on 9/30/18.
//  Copyright © 2018 Barsam. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(value: T)
    case failure
}
