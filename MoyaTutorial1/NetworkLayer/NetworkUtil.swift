//
//  NetworkUtil.swift
//  MoyaTutorial1
//
//  Created by Yunus Emre Celebi on 12.01.2020.
//  Copyright © 2020 cLB. All rights reserved.
//

import Foundation

enum APIEnvironment {
    case staging
    case dev
    case production
}

struct NetworkUtil {
    private static let environment: APIEnvironment = .dev

    static var environmentBaseURL: String {
        switch NetworkUtil.environment {
        case .production: return "https://jsonplaceholder.typicode.com"
        case .staging: return "https://jsonplaceholder.typicode.com"
        case .dev: return "https://jsonplaceholder.typicode.com"
        }
    }
}
