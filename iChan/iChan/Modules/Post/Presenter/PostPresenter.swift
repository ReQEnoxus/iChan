//
//  PostPresenter.swift
//  iChan
//
//  Created by Enoxus on 02/04/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

class PostPresenter: PostViewOutput, PostInteractorOutput {
    
    weak var view: PostViewInput!
    var interactor: PostInteractorInput!
    var router: PostRouterInput!
    
    var posts: [Post]!
    var initialNum: String!
    var board: String!
    
    //MARK: - View Output
    func didTapImage(index: Int, files: [File]) {
        router.presentImage(index: index, files: files)
    }
    
    func didTapUrl(url: URL) {
        interactor.didTapUrl(url: url)
    }
    
    func initialSetup() {
        
        let postCandidate = posts.first(where: { $0.num == initialNum })
        
        if let post = postCandidate {
            view.configure(with: post)
        }
    }
    
    func dismissRequested() {
        router.dismissPostModule()
    }
    
    func postNumberButtonPressed(replyingTo: String) {
        router.presentReplyController(board: board, threadNum: posts[.zero].num, replyingTo: replyingTo)
    }
    
    //MARK: - Interactor Output
    func didFinishCheckingUrl(type: UrlType) {
        
        switch type {
            
            case .inner(let board, let opNum, let postNum):
                
                if opNum == posts[0].num {
                    // working with post in this thread
                    
                    if let requestedPostNum = postNum {
                        
                        if let requestedPost = posts.first(where: { $0.num == requestedPostNum }) {
                            
                            view.configure(with: requestedPost)
                        }
                    }
                else {
                    
                    view.configure(with: posts[0])
                }
            }
            else {
                router.dismissPostModuleAndPushThread(board: board, opNum: opNum, postNum: postNum)
            }
            
            case .innerReply(let num):
            
                let postCandidate = posts.first(where: { $0.num == num })
                
                if let post = postCandidate {
                    view.configure(with: post)
                }
            
            case .outer(let url):
                router.open(url: url)
        }
    }
}
