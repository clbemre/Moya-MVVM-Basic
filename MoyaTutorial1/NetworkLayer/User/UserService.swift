//
//  UserService.swift
//  MoyaTutorial1
//
//  Created by Yunus Emre Celebi on 11.01.2020.
//  Copyright © 2020 cLB. All rights reserved.
//

import Moya

enum UserService {
    case createUser(name: String)
    case readUsers
    case updateUser(id: Int, name: String)
    case deleteUser(id: Int)
}

extension UserService: TargetType {

    var baseURL: URL {
        guard let url = URL(string: NetworkUtil.environmentBaseURL) else { fatalError("baseURL could not be configured") }
        return url
    }

    var path: String {
        switch self {
        case .readUsers, .createUser(_):
            return "/users"
        case .updateUser(let id, _), .deleteUser(let id):
            return "/users/\(id)"
        }
    }

    var method: Moya.Method {
        switch self {
        case .createUser(_):
            return .post
        case .readUsers:
            return .get
        case .updateUser(_, _):
            return .put
        case .deleteUser(_):
            return .delete
        }
    }

    var sampleData: Data {
        switch self {
        case .createUser(let name):
            return "{ 'name' : '\(name)' }".data(using: .utf8)!
        case .readUsers:
            return Data()
        case .updateUser(let id, let name):
            return "{ 'id' : '\(id)', 'name' : '\(name)' }".data(using: .utf8)!
        case .deleteUser(let id):
            return "{ 'id' : '\(id)' }".data(using: .utf8)!
        }
    }

    var task: Task {
        switch self {
        case .readUsers, .deleteUser(_):
            return .requestPlain
        case .createUser(let name):
            return .requestParameters(parameters: ["name": name], encoding: JSONEncoding.default)
        case .updateUser(let id, let name):
            return .requestParameters(parameters: ["id": id, "name": name], encoding: JSONEncoding.default)
        }
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
}
