//
//  ReviewsViewModel.swift
//  TopReview
//
//  Created by Muhammad Fahied on 2/9/19.
//  Copyright © 2019 Fahied. All rights reserved.
//
import UIKit
import Foundation

//MARK: -
protocol ReviewsViewModelDelegate: class {
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?)
    func onFetchFailed(with reason: String)
}

final class ReviewsViewModel {
    private weak var delegate: ReviewsViewModelDelegate?
    private var reviews: [Review] = []
    private var isFetchInProgress = false
    private var currentPage = 0
    private var total = 0
    private let reviewAPI = ReviewAPIService()
    private let request: ReviewRequest
    
    
    var totalCount: Int { return total }
    var currentCount: Int { return reviews.count }
    
    init(request: ReviewRequest, delegate: ReviewsViewModelDelegate) {
        self.request = request
        self.delegate = delegate
    }
    
    func reviewViewModel(at index: Int) -> ReviewViewModel {
        return ReviewViewModel(review: reviews[index])
    }
    
    func fetchReviews() {
        guard !isFetchInProgress else { return }
        
        isFetchInProgress = true
        reviewAPI.fetch(with: request, page: currentPage) { result in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self.isFetchInProgress = false
                    self.delegate?.onFetchFailed(with: error.reason)
                }
            case .success(let response):
                DispatchQueue.main.async {
                    guard let response = response else {self.delegate?.onFetchCompleted(with: .none); return}
                    self.currentPage += 1
                    self.isFetchInProgress = false
                    self.total = response.total
                    self.reviews.append(contentsOf: response.reviews)
                    
                    if self.currentPage > 1 {
                        let indexPathsToReload = self.calculateIndexPathsToReload(from: response.reviews)
                        self.delegate?.onFetchCompleted(with: indexPathsToReload)
                    } else {
                        self.delegate?.onFetchCompleted(with: .none)
                    }
                }
            }
        }
    }
    
    private func calculateIndexPathsToReload(from newReviews: [Review]) -> [IndexPath] {
        let startIndex = reviews.count - newReviews.count
        let endIndex = startIndex + newReviews.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
}
