//
//  Review.swift
//  TopReview
//
//  Created by Muhammad Fahied on 2/8/19.
//  Copyright © 2019 Fahied. All rights reserved.
//

import Foundation

struct DateUnformated: Codable {}

struct Review: Codable {
    var review_id: Int
    var rating: String
    var title: String?
    var message: String
    var author: String
    var foreignLanguage: Bool
    var date: String
    var date_unformatted: DateUnformated
    var languageCode: String
    var traveler_type: String?
    var reviewerName: String
    var reviewerCountry: String
}
