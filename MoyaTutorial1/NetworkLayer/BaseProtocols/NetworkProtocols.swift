//
//  NUser.swift
//  MoyaTutorial1
//
//  Created by Yunus Emre Celebi on 11.01.2020.
//  Copyright © 2020 cLB. All rights reserved.
//

import Moya

protocol UserProtocol {

    func readUsers(completion: @escaping ([User]?, Error?) -> Void)
    func createUser(name: String, completion: @escaping (User?, Error?) -> Void)
    func updateUser(id: Int, name: String, completion: @escaping (User?, Error?) -> Void)
    func deleteUser(id: Int, completion: @escaping (Error?) -> Void)
}
