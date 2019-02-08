//
//  ReviewCellViewModel.swift
//  TopReview
//
//  Created by Muhammad Fahied on 2/8/19.
//  Copyright © 2019 Fahied. All rights reserved.
//

import Foundation
import FontAwesome_swift

class ReviewCellViewModel {
    let rating: NSAttributedString
    let title: String
    let message: String
    let author: String
    let date: String
    let isHelpful:Observable<Bool>
    let backgroundColor: UIColor
    
    init(review: Review) {
        rating = NSAttributedString.starRating(filledStars: review.rating.intValue)
        title = review.title ?? ""
        message = review.message
        author = review.author
        date = review.date.shortDate()
        isHelpful = Observable(false)
        backgroundColor = .easyGrey
    }
}
