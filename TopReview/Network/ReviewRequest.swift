//
//  ReviewRequest.swift
//  TopReview
//
//  Created by Muhammad Fahied on 2/9/19.
//  Copyright © 2019 Fahied. All rights reserved.
//

import Foundation

typealias Parameters = [String: String]

//https://www.getyourguide.com/berlin-l17/tempelhof-2-hour-airport-history-tour-berlin-airlift-more-t23776/reviews.json?count=5&page=0&rating=0&sortBy=date_of_review&direction=DESC
struct ReviewRequest {
    let cityCode: String
    let postId: String
    var path: String { return "\(cityCode)/\(postId)/reviews.json" }
    let parameters: Parameters

    private init(cityCode:String, postId: String, parameters: Parameters) {
        self.cityCode = cityCode
        self.postId = postId
        self.parameters = parameters
    }
}

extension ReviewRequest {
    static func from(cityCode:String, postId: String) -> ReviewRequest {
        let defaultParameters = ["rating": "0", "sortBy": "date_of_review", "direction": "DESC", "count":"20"]
        return ReviewRequest(cityCode: cityCode, postId: postId, parameters: defaultParameters)
    }
}


extension URLRequest {
    func encode(with parameters: Parameters?) -> URLRequest {
        guard let parameters = parameters else {
            return self
        }
        
        var encodedURLRequest = self
        
        if let url = self.url,
            let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false),
            !parameters.isEmpty {
            var newUrlComponents = urlComponents
            let queryItems = parameters.map { key, value in
                URLQueryItem(name: key, value: value)
            }
            newUrlComponents.queryItems = queryItems
            encodedURLRequest.url = newUrlComponents.url
            return encodedURLRequest
        } else {
            return self
        }
    }
}
