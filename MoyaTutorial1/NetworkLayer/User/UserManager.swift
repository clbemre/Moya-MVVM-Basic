//
//  UserManager.swift
//  MoyaTutorial1
//
//  Created by Yunus Emre Celebi on 11.01.2020.
//  Copyright © 2020 cLB. All rights reserved.
//

import Moya

class UserManager: BaseManager<UserService, MoyaProvider<UserService>>, UserProtocol {

    override init(provider: MoyaProvider<UserService>) {
        super.init(provider: provider)
    }

    func readUsers(completion: @escaping ([User]?, Error?) -> Void) {
        mRequest(.readUsers, callback: completion)
    }

    func createUser(name: String, completion: @escaping (User?, Error?) -> Void) {
        mRequest(.createUser(name: name), callback: completion)
    }

    func updateUser(id: Int, name: String, completion: @escaping (User?, Error?) -> Void) {
        mRequest(.updateUser(id: id, name: "[Modified] \(name)"), callback: completion)
    }

    func deleteUser(id: Int, completion: @escaping (Error?) -> Void) {
        mRequest(.deleteUser(id: id), callback: completion)
    }
}
