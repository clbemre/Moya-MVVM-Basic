//
//  ViewController.swift
//  MoyaTutorial1
//
//  Created by Yunus Emre Celebi on 11.01.2020.
//  Copyright © 2020 cLB. All rights reserved.
//

import UIKit
import Moya
import NVActivityIndicatorView

class ViewController: UITableViewController {

    // MARK: Vars

    var userViewModel: UserViewModel = UserViewModelFactory().makeViewModel()
    var activityIndicator: NVActivityIndicatorView?

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.5818830132, green: 0.2156915367, blue: 1, alpha: 1)
        tableView.tableFooterView = UIView()

        /*let userProvider = MoyaProvider<UserService>(plugins: [NetworkLoggerPlugin(verbose: true)])
        userProvider.manager.session.configuration.timeoutIntervalForRequest = 120
        let userManager = UserManager(userProvider: userProvider)
        userViewModel = UserViewModel(userManager: userManager) */

        userViewModel.delegate = self
        userViewModel.readUser()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        activityIndicator = NVActivityIndicatorView(frame: CGRect(x: self.view.frame.width / 2 - 30, y: self.view.frame.height / 2 - 30, width: 60, height: 60), type: .ballBeat, color: #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1), padding: nil)
    }

    // MARK: IBActions
    @IBAction func didTapAdd() {
        self.userViewModel.createUser(name: "Emre Celebi \(Int.random(in: 0..<61))")
    }

    // MARK: TableView Delegate&Datasource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userViewModel.numberOfRowsInSection()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TitleTableViewCell()
        cell.generateCell(title: userViewModel.getUserName(at: indexPath.row))
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let user = userViewModel.getUser(at: indexPath.row)
        userViewModel.updateUser(indexPath: indexPath, id: user.id, name: user.name)
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        let user = userViewModel.getUser(at: indexPath.row)
        userViewModel.deleteUser(indexPath: indexPath, id: user.id)

    }
}

// MARK: UserViewModelDelegate

extension ViewController: UserViewModelDelegate {
    func showLoading() {
        showLoadingIndicator()
    }

    func hideLoading() {
        hideLoadingIndicator()
    }

    func showErrorMessage(message: String) {
        let alert = UIAlertController(title: "Hata!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    func readedUser() {
        self.tableView.reloadData()
    }

    func createdUser(index: Int) {
        self.tableView.insertRows(at: [IndexPath(item: 0, section: 0)], with: .right)
    }

    func updatedUser(indexPath: IndexPath) {
        self.tableView.performBatchUpdates({
            self.tableView.reloadRows(at: [indexPath], with: .fade)
        }, completion: nil)
    }

    func deletedUser(indexPath: IndexPath) {
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
    }

}

// Like BaseViewController

extension ViewController {

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
