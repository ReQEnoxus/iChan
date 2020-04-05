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
    
    //MARK: - Interactor Output
    func didFinishCheckingUrl(type: UrlType) {
        
        switch type {
            
            case .innerReply(_, _, let parent):
                
                let postCandidate = posts.first(where: { $0.num == parent })
                
                if let post = postCandidate {
                    view.configure(with: post)
                }
            
            case .inner(_, let num):
                
                let postCandidate = posts.first(where: { $0.num == num })
                
                if let post = postCandidate {
                    view.configure(with: post)
                }
                
            case .outer(let url):
                router.open(url: url)
        }
    }
}
