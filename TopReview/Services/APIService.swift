//
//  APIService.swift
//  TopReview
//
//  Created by Muhammad Fahied on 2/8/19.
//  Copyright © 2019 Fahied. All rights reserved.
//

import Foundation
import Alamofire


class APIService {
    
    func fetchReviews(completionHandler: @escaping (PagedReviews) -> Void){
        let urlString = "https://www.getyourguide.com/berlin-l17/tempelhof-2-hour-airport-history-tour-berlin-airlift-more-t23776/reviews.json?count=50&page=0&rating=0&type=&sortBy=date_of_review&direction=DESC"
        
        Alamofire.request(urlString).responseJSON { response in
            if let data = response.data{
                do {
                    let decoder = JSONDecoder()
                    let pagedReview = try decoder.decode(PagedReviews.self, from: data)
                    completionHandler(pagedReview)
                } catch let parsingError {
                    print("Error", parsingError)
                }
            }
        }
    }
}
