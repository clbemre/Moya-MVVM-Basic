//
//  BaseRequest.swift
//  MoyaTutorial1
//
//  Created by Yunus Emre Celebi on 12.01.2020.
//  Copyright © 2020 cLB. All rights reserved.
//

import Moya

protocol IBaseManager {
    associatedtype Target: TargetType
}

class BaseManager<Type: TargetType, P: MoyaProvider<Type>>: IBaseManager {
    
    typealias Target = Type
    private var provider: P

    init(provider: P) {
        self.provider = provider
    }

    func mRequest<T: Codable>
    (_ target: Target, callback: @escaping (T?, Error?) -> Void) {

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

    func mRequest(_ target: Target, callback: @escaping (Error?) -> Void) {
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
