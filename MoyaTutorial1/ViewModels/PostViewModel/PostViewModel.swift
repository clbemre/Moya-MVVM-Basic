//
//  PostViewModel.swift
//  MoyaTutorial1
//
//  Created by Yunus Emre Celebi on 12.01.2020.
//  Copyright © 2020 cLB. All rights reserved.
//

import Foundation

protocol PostViewModelDelegate: BaseViewModelDelegate {
    func readedPosts()
}


class PostViewModel: IBaseViewModel {

    let postManager: PostManager
    private var posts = [Post]()
    var delegate: PostViewModelDelegate?

    init(postManager: PostManager) {
        self.postManager = postManager
    }

    func readPosts(userId: Int) {
        self.delegate?.showLoading()
        postManager.readPosts(userId: userId) { (posts, error) in
            self.delegate?.hideLoading()
            if let error = error {
                self.delegate?.showErrorMessage(message: error.localizedDescription)
            }

            self.posts = posts!
            self.delegate?.readedPosts()
        }
    }

    func numberOfRowsInSection() -> Int {
        return posts.count
    }

    func getPost(at index: Int) -> Post {
        return posts[index]
    }
}
