//
//  SecondViewController.swift
//  TopReview
//
//  Created by Muhammad Fahied on 2/7/19.
//  Copyright © 2019 Fahied. All rights reserved.
//

import UIKit
import FontAwesome_swift

class ReviewsViewController: UIViewController, AlertDisplayable {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!

    //TODO: viewModel should be injected for now we ll initialize in viewDidLoad
    private var viewModel: ReviewsViewModel!
    let request = ReviewRequest.from(cityCode: "berlin-l17", postId: "tempelhof-2-hour-airport-history-tour-berlin-airlift-more-t23776")
    
    //MARK: - LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        tableView.prefetchDataSource = self
        viewModel = ReviewsViewModel(request: request, delegate: self)
        viewModel.fetchReviews()
    }
}

//MARK: - UITableViewDelegate & UITableViewDataSource
extension ReviewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.totalCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ReviewCell.reuseIdentifier, for: indexPath) as! ReviewCell
        if isLoadingCell(for: indexPath) {
            cell.configure(with: .none)
        } else {
            cell.configure(with: viewModel.reviewViewModel(at: indexPath.row))
        }
        return cell
    }
}
//MARK: - UITableViewDataSourcePrefetching
extension ReviewsViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            viewModel.fetchReviews()
        }
    }
}

//MARK: - ReviewsViewModelDelegate
extension ReviewsViewController: ReviewsViewModelDelegate {
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?) {
        indicatorView.isHidden = true
        guard let newIndexPathsToReload = newIndexPathsToReload else {
            tableView.isHidden = false
            tableView.reloadData()
            return
        }
        
        let indexPathsToReload = visibleIndexPathsToReload(intersecting: newIndexPathsToReload)
        tableView.reloadRows(at: indexPathsToReload, with: .automatic)
    }
    
    func onFetchFailed(with reason: String) {
        indicatorView.stopAnimating()
        let title = "Alert"
        let action = UIAlertAction(title: "OK", style: .default)
        displayAlert(with: title , message: reason, actions: [action])
    }
}

//MARK: - Private Helper Functions
private extension ReviewsViewController {
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= viewModel.currentCount
    }
    
    func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
        let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows ?? []
        let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
        return Array(indexPathsIntersection)
    }
}
