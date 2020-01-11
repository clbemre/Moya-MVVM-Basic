//
//  UserViewModelFactory.swift
//  MoyaTutorial1
//
//  Created by Yunus Emre Celebi on 12.01.2020.
//  Copyright © 2020 cLB. All rights reserved.
//

import Moya

class UserViewModelFactory: ViewModelFactory {

    typealias Target = UserService
    typealias B = UserManager
    typealias V = UserViewModel

    func makeProvider() -> MoyaProvider<UserService> {
        let userProvider = MoyaProvider<UserService>(plugins: [NetworkLoggerPlugin(verbose: true)])
        userProvider.manager.session.configuration.timeoutIntervalForRequest = 120
        return userProvider
    }

    func makeManager() -> UserManager {
        return UserManager(userProvider: makeProvider())
    }

    func makeViewModel() -> UserViewModel {
        return UserViewModel(userManager: makeManager())
    }
}
