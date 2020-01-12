//
//  BaseTableViewController.swift
//  MoyaTutorial1
//
//  Created by Yunus Emre Celebi on 12.01.2020.
//  Copyright © 2020 cLB. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class BaseTableViewController: UITableViewController {

    var activityIndicator: NVActivityIndicatorView?

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        activityIndicator = NVActivityIndicatorView(frame: CGRect(x: self.view.frame.width / 2 - 30, y: self.view.frame.height / 2 - 30, width: 60, height: 60), type: .ballBeat, color: #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1), padding: nil)
    }

    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Hata!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension BaseTableViewController {

    // MARK: Activity Indicator
    func showLoadingIndicator() {
        if let activityIndicator = activityIndicator {
            self.view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
        }
    }

    func hideLoadingIndicator() {
        if let activityIndicator = activityIndicator {
            activityIndicator.removeFromSuperview()
            activityIndicator.stopAnimating()
        }
    }
}
