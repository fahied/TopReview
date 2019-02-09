//
//  AlertDisplayable.swift
//  TopReview
//
//  Created by Muhammad Fahied on 2/9/19.
//  Copyright © 2019 Fahied. All rights reserved.
//

import Foundation

import Foundation
import UIKit

protocol AlertDisplayable {
    func displayAlert(with title: String, message: String, actions: [UIAlertAction]?)
}

extension AlertDisplayable where Self: UIViewController {
    func displayAlert(with title: String, message: String, actions: [UIAlertAction]? = nil) {
        guard presentedViewController == nil else {
            return
        }
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions?.forEach { action in
            alertController.addAction(action)
        }
        present(alertController, animated: true)
    }
}
