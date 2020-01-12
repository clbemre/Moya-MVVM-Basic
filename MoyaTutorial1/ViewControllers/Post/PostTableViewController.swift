//
//  PostTableViewController.swift
//  MoyaTutorial1
//
//  Created by Yunus Emre Celebi on 12.01.2020.
//  Copyright © 2020 cLB. All rights reserved.
//

import UIKit

class PostTableViewController: BaseTableViewController {

    // MARK: Vars

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
        self.setupUI()
        self.setupRefreshControl()

        postViewModel.delegate = self
        postViewModel.readPosts(userId: userId)
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
        showErrorAlert(message: message)
    }

    func readedPosts() {
        self.tableView.reloadData()
    }

}

// MARK: Setup
extension PostTableViewController {

    func setupUI() {
        view.backgroundColor = #colorLiteral(red: 0.5818830132, green: 0.2156915367, blue: 1, alpha: 1)
        tableView.tableFooterView = UIView()
    }

    func setupRefreshControl() {
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.tintColor = .white
        self.refreshControl?.addTarget(self, action: #selector(self.refreshTableView(sender:)), for: .valueChanged)
    }
}
