//
//  NSAttributedString+Extension.swift
//  TopReview
//
//  Created by Muhammad Fahied on 2/8/19.
//  Copyright © 2019 Fahied. All rights reserved.
//

import UIKit

extension NSAttributedString {
    static func starRating(filledStars:Int, totalStars: Int = 5) -> NSAttributedString {
        let activeStarAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.fontAwesome(ofSize: 18, style: .solid),
            .foregroundColor: UIColor.gold]
        let inactiveStarAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.fontAwesome(ofSize: 18, style: .regular),
            .foregroundColor: UIColor.gold]
        
        let stars = NSMutableAttributedString()
        for _ in 0..<filledStars {
            stars.append(NSAttributedString(string: String.fontAwesomeIcon(name: .star), attributes: activeStarAttributes))
        }
        
        for _ in 0..<totalStars-filledStars {
            stars.append(NSAttributedString(string: String.fontAwesomeIcon(name: .star), attributes: inactiveStarAttributes))
        }
        return stars
    }
}
