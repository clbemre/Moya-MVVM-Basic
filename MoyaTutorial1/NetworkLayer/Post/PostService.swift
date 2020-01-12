//
//  PostService.swift
//  MoyaTutorial1
//
//  Created by Yunus Emre Celebi on 12.01.2020.
//  Copyright © 2020 cLB. All rights reserved.
//

import Moya

enum PostService {
    case readPosts(userId: Int)
}

extension PostService: TargetType {

    var baseURL: URL {
        guard let url = URL(string: NetworkUtil.environmentBaseURL) else { fatalError("baseURL could not be configured") }
        return url
    }

    var path: String {
        switch self {
        case .readPosts(_):
            return "/posts"
        }
    }

    var method: Moya.Method {
        switch self {
        case .readPosts(_):
            return .get
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case .readPosts(let userId):
            return .requestParameters(parameters: ["userId": userId], encoding: URLEncoding.default)
        }
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
}
