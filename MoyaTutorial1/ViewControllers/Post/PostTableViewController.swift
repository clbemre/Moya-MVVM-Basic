//
//  PostTableViewController.swift
//  MoyaTutorial1
//
//  Created by Yunus Emre Celebi on 12.01.2020.
//  Copyright © 2020 cLB. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class PostTableViewController: UITableViewController {

    // MARK: Vars

    // var postViewModel: PostViewModel = PostViewModelFactory().makeViewModel()
    var activityIndicator: NVActivityIndicatorView?

    let postViewModel: PostViewModel
    let userId: Int

    // Dependency Injection for ViewModel
    init(userId: Int, vm: PostViewModel) {
        self.userId = userId
        self.postViewModel = vm
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.5818830132, green: 0.2156915367, blue: 1, alpha: 1)
        tableView.tableFooterView = UIView()

        self.refreshControl = UIRefreshControl()
        self.refreshControl?.tintColor = .white
        self.refreshControl?.addTarget(self, action: #selector(self.refreshTableView(sender:)), for: .valueChanged)


        postViewModel.delegate = self
        postViewModel.readPosts(userId: userId)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        activityIndicator = NVActivityIndicatorView(frame: CGRect(x: self.view.frame.width / 2 - 30, y: self.view.frame.height / 2 - 30, width: 60, height: 60), type: .ballBeat, color: #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1), padding: nil)
    }

    // MARK: IBActions
    @objc func refreshTableView(sender: AnyObject) {
        postViewModel.readPosts(userId: userId)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.postViewModel.numberOfRowsInSection()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = self.postViewModel.getPost(at: indexPath.row).title
        return cell
    }
}


// MARK: PostViewModelDelegate
extension PostTableViewController: PostViewModelDelegate {

    func showLoading() {
        showLoadingIndicator()
    }

    func hideLoading() {
        refreshControl?.endRefreshing()
        hideLoadingIndicator()
    }

    func showErrorMessage(message: String) {
        let alert = UIAlertController(title: "Hata!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    func readedPosts() {
        self.tableView.reloadData()
    }

}


// Like BaseViewController
extension PostTableViewController {

    // MARK: Activity Indicator
    private func showLoadingIndicator() {
        if let activityIndicator = activityIndicator {
            self.view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
        }
    }

    private func hideLoadingIndicator() {
        if let activityIndicator = activityIndicator {
            activityIndicator.removeFromSuperview()
            activityIndicator.stopAnimating()
        }
    }
}
