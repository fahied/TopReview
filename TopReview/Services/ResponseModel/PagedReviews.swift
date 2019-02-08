//
//  PagedReviews.swift
//  TopReview
//
//  Created by Muhammad Fahied on 2/8/19.
//  Copyright © 2019 Fahied. All rights reserved.
//

import Foundation

struct PagedReviews : Codable {
    
    let status: Bool
    let total: Int
    let reviews: [Review]
    
    enum CodingKeys : String, CodingKey {
        case status
        case total = "total_reviews_comments"
        case reviews = "data"
    }
}

