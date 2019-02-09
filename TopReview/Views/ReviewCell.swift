//
//  ReviewCell.swift
//  TopReview
//
//  Created by Muhammad Fahied on 2/7/19.
//  Copyright © 2019 Fahied. All rights reserved.
//

import Foundation
import UIKit


class ReviewCell: UITableViewCell, Identifiable {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var helpfulButton: UIButton!
    @IBOutlet weak var helpfulLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        configure(with: .none)
    }
    
    func configure(with viewModel: ReviewViewModel?) {
        if let viewModel = viewModel {
            self.containerView.alpha = 1.0
            titleLabel.text = viewModel.title
            dateLabel.text = viewModel.date
            authorLabel.text = viewModel.author
            messageLabel.text = viewModel.message
            ratingLabel.attributedText = viewModel.rating
            helpfulButton.setTitle("Yes", for: .normal)
            helpfulLabel.text = "Was this helpful?"
        } else {
            self.containerView.alpha = 0.1 // just little fun for now
            helpfulButton.applyStyle(selected: false)
        }
    }
    
    @IBAction func helpfulButtonPressed(_ sender: UIButton) {
        sender.applyStyle(selected: true)
        //TODO: Update model to save the button state
    }
}

//MARK: - Helper
private extension UIButton {
    func applyStyle(selected: Bool) {
        if selected {
            self.backgroundColor = .easyBlue
            self.setTitleColor(.white, for: .normal)
            
        }else {
            self.backgroundColor = .clear
            self.setTitleColor(.easyBlue, for: .normal)
        }
    }
}
