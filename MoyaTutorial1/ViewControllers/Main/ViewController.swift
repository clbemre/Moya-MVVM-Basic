//
//  ViewController.swift
//  MoyaTutorial1
//
//  Created by Yunus Emre Celebi on 11.01.2020.
//  Copyright © 2020 cLB. All rights reserved.
//

import UIKit
import Moya

class ViewController: BaseTableViewController {

    // MARK: Vars

    var userViewModel: UserViewModel = UserViewModelFactory().makeViewModel()

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()

        /*let userProvider = MoyaProvider<UserService>(plugins: [NetworkLoggerPlugin(verbose: true)])
        userProvider.manager.session.configuration.timeoutIntervalForRequest = 120
        let userManager = UserManager(userProvider: userProvider)
        userViewModel = UserViewModel(userManager: userManager) */

        userViewModel.delegate = self
        userViewModel.readUser()
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
        // userViewModel.updateUser(indexPath: indexPath, id: user.id, name: user.name)

        let postViewController = PostTableViewController(
            userId: user.id,
            vm: PostViewModelFactory().makeViewModel()
        )
        self.navigationController?.pushViewController(postViewController, animated: true)
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
        showErrorAlert(message: message)
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

// MARK: Setup
extension ViewController {

    func setupUI() {
        view.backgroundColor = #colorLiteral(red: 0.5818830132, green: 0.2156915367, blue: 1, alpha: 1)
        tableView.tableFooterView = UIView()
    }
}
