//
//  ReviewAPIService.swift
//  TopReview
//
//  Created by Muhammad Fahied on 2/9/19.
//  Copyright © 2019 Fahied. All rights reserved.
//

import Foundation

class ReviewAPIService: APIService {
    let session: URLSession
    
    private lazy var baseURL: URL = {
        return URL(string: "https://www.getyourguide.com/")!
    }()

    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    func fetch(with request: ReviewRequest, page: Int, completion: @escaping (Result<PagedReviewsResponse?, APIError>) -> Void) {
        
        let urlRequest = URLRequest(url: baseURL.appendingPathComponent(request.path))
        let parameters = ["page": "\(page)"].merging(request.parameters, uniquingKeysWith: +)
        let request = urlRequest.encode(with: parameters)
        
        fetch(with: request, decode: { json -> PagedReviewsResponse? in
            guard let movieFeedResult = json as? PagedReviewsResponse else { return  nil }
            return movieFeedResult
        }, completion: completion)
    }
}
