//
//  NetworkManager.swift
//  MoyaTutorial1
//
//  Created by Yunus Emre Celebi on 11.01.2020.
//  Copyright © 2020 cLB. All rights reserved.
//

import Moya

class UserManager: UserProtocol, BaseManager {
    
    typealias Target = UserService

    var userProvider: MoyaProvider<UserService>

    init(userProvider: MoyaProvider<UserService>) {
        self.userProvider = userProvider
    }

    func readUsers(completion: @escaping ([User]?, Error?) -> Void) {
        mRequest(userProvider, .readUsers, callback: completion)
    }

    func createUser(name: String, completion: @escaping (User?, Error?) -> Void) {
        mRequest(userProvider, .createUser(name: name), callback: completion)
    }

    func updateUser(id: Int, name: String, completion: @escaping (User?, Error?) -> Void) {
        mRequest(userProvider, .updateUser(id: id, name: "[Modified] \(name)"), callback: completion)
    }

    func deleteUser(id: Int, completion: @escaping (Error?) -> Void) {
        mRequest(userProvider, .deleteUser(id: id), callback: completion)
    }

    private func mRequest<P: MoyaProvider<Target>, T: Codable>
    (_ provider: P, _ target: UserService, callback: @escaping (T?, Error?) -> Void) {

        provider.request(target) { (result) in
            switch result {
            case .success(let response):
                do {
                    let users = try JSONDecoder().decode(T.self, from: response.data)
                    callback(users, nil)
                } catch (let error) {
                    callback(nil, error)
                }
            case .failure(let error):
                callback(nil, error)
            }
        }
    }

    private func mRequest<P: MoyaProvider<Target>>(_ provider: P, _ target: UserService, callback: @escaping (Error?) -> Void) {
        provider.request(target) { (result) in
            switch result {
            case .success(_):
                callback(nil)
            case .failure(let error):
                callback(error)
            }
        }
    }
}
