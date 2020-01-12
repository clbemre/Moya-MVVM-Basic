//
//  PostManager.swift
//  MoyaTutorial1
//
//  Created by Yunus Emre Celebi on 12.01.2020.
//  Copyright © 2020 cLB. All rights reserved.
//

import Moya

protocol PostProtocol {
    func readPosts(userId: Int, completion: @escaping ([Post]?, Error?) -> Void)
}

class PostManager: BaseManager<PostService, MoyaProvider<PostService>>, PostProtocol {

    init(postProvider: MoyaProvider<PostService>) {
        super.init(provider: postProvider)
    }

    func readPosts(userId: Int, completion: @escaping ([Post]?, Error?) -> Void) {
        mRequest(.readPosts(userId: userId), callback: completion)
    }

}

