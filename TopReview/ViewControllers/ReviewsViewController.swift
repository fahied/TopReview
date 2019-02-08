//
//  SecondViewController.swift
//  TopReview
//
//  Created by Muhammad Fahied on 2/7/19.
//  Copyright © 2019 Fahied. All rights reserved.
//

import UIKit
import FontAwesome_swift

class ReviewsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let apiService = APIService()
    var reviews = [Review]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        apiService.fetchReviews { (pagedReviews) in
            self.reviews = pagedReviews.reviews
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}


extension ReviewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ratingCell", for: indexPath) as! ReviewCell
        let review = reviews[indexPath.row]
        let viewModel = ReviewCellViewModel(review: review)
        cell.setup(viewModel: viewModel)
        return cell
    }
}
