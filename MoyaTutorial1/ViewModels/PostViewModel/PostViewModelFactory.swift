//
//  PostViewModelFactory.swift
//  MoyaTutorial1
//
//  Created by Yunus Emre Celebi on 12.01.2020.
//  Copyright © 2020 cLB. All rights reserved.
//

import Moya

class PostViewModelFactory: ViewModelFactory {

    typealias Target = PostService
    typealias B = PostManager
    typealias V = PostViewModel

    func makeProvider() -> MoyaProvider<PostService> {
        return createMoyaProvider(targetType: PostService.self)
    }

    func makeManager() -> PostManager {
        return PostManager(postProvider: makeProvider())
    }

    func makeViewModel() -> PostViewModel {
        return PostViewModel(postManager: makeManager())
    }

}
