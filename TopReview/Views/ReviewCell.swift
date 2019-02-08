//
//  ReviewCell.swift
//  TopReview
//
//  Created by Muhammad Fahied on 2/7/19.
//  Copyright © 2019 Fahied. All rights reserved.
//

import Foundation
import UIKit


class ReviewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var helpfulButton: UIButton!
    @IBOutlet weak var helpfulLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    func setup(viewModel: ReviewCellViewModel) {
        // The imange and the name won't be changed after setup
        titleLabel.text = viewModel.title
        dateLabel.text = viewModel.date
        authorLabel.text = viewModel.author
        messageLabel.text = viewModel.message
        ratingLabel.attributedText = viewModel.rating
        helpfulButton.setTitle("Yes", for: .normal)
        helpfulLabel.text = "Was this helpful?"
        // containerView.backgroundColor = viewModel.backgroundColor
        // Listen to the change of the isHelpful property to update the UI state
        viewModel.isHelpful.valueChanged = { [weak self] (isHelpful)  in
            self?.helpfulLabel.backgroundColor = isHelpful ?  .lightGray : .white
        }
    }
    
    @IBAction func helpfulButtonPressed(_ sender: Any) {
        //TODO: sync status with server and update button theme
    }
}
