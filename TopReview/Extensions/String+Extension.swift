//
//  String+Extension.swift
//  TopReview
//
//  Created by Muhammad Fahied on 2/8/19.
//  Copyright © 2019 Fahied. All rights reserved.
//

import Foundation

extension String {
    
    var intValue:Int {
        return Int(Double(self) ?? 0)
    }
    
    func shortDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = "MMM yy"
            let dateString = dateFormatter.string(from: date)
            return dateString
        }
        return self
    }
}

