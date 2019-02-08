//
//  Observer.swift
//  TopReview
//
//  Created by Muhammad Fahied on 2/8/19.
//  Copyright © 2019 Fahied. All rights reserved.
//

import Foundation

class Observable<T> {
    var value: T {
        didSet {
            DispatchQueue.main.async {
                self.valueChanged?(self.value)
            }
        }
    }
    
    init(_ v: T) {
        value = v
    }
    var valueChanged: ((T) -> Void)?
}
