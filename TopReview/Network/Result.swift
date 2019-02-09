//
//  Result.swift
//  TopReview
//
//  Created by Muhammad Fahied on 2/9/19.
//  Copyright © 2019 Fahied. All rights reserved.
//

import Foundation

enum Result<T, U: Error> {
    case success(T)
    case failure(U)
}
