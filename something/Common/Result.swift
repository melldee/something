//
//  Result.swift
//  something
//
//  Created by Maxim Semenov on 30/06/2019.
//  Copyright © 2019 Maxim Semenov. All rights reserved.
//

import Foundation

enum Result<T>{
    case success(T)
    case failure(Error)
}
