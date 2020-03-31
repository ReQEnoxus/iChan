//
//  BoardThreadsServiceImpl.swift
//  iChan
//
//  Created by Enoxus on 15/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

class BoardThreadsServiceImpl: AbstractApiClientService, BoardThreadsService {
    
    private var page = 0
        
    func getMoreThreads(board: String, completion: @escaping (Result<[ThreadDto], ApiError>) -> Void) {
        
        request(endpoint: .board(id: board, page: page)) { [weak self] (result: Result<ThreadResponse, ApiError>) in
            
            guard let self = self else { return }
            
            switch result {
                
                case .failure(let error):
                    
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                case .success(let threadResponse):
                    
                    var dtoArray: [ThreadDto] = []
                    
                    for thread in threadResponse.threads {
                        
                        var thumbNail: String? = nil
                        var file: String? = nil
                        var fileName: String? = nil
                        
                        if let path = thread.posts[0].files?.first?.thumbnail {
                            thumbNail = Endpoint.baseUrl + path
                        }
                        
                        if let path = thread.posts[0].files?.first?.path {
                            file = Endpoint.baseUrl + path
                        }
                        
                        if let name = thread.posts[0].files?.first?.displayname {
                            fileName = name
                        }
                        
                        let dto = ThreadDto(number: thread.posts[0].num,
                                            filesCount: thread.filesCount ?? 0,
                                            postsCount: thread.postsCount ?? 0,
                                            date: thread.posts[0].date,
                                            thumbnail: thumbNail,
                                            file: file,
                                            text: thread.posts[0].comment,
                                            posterName: thread.posts[0].name,
                                            fileName: fileName)
                        
                        dtoArray.append(dto)
                    }
                    
                    DispatchQueue.main.async {
                        completion(.success(dtoArray))
                    }
                    
                    self.page += 1
            }
        }
    }
    
    func loadThread(board: String, num: String, completion: @escaping (Result<Thread, ApiError>) -> Void) {
        
        request(endpoint: .thread(board: board, num: num)) { (result: Result<ThreadResponse, ApiError>) in
                        
            switch result {
                
                case .failure(let error):
                    
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                case .success(let threadResponse):
                    
                    let thread = threadResponse.threads[0]
                    
                    for i in 0 ..< thread.posts.count {
                        
                        if thread.posts[i].files != nil {
                            
                            for j in 0 ..< thread.posts[i].files!.count {
                                
                                thread.posts[i].files![j].path = Endpoint.baseUrl + thread.posts[i].files![j].path
                                thread.posts[i].files![j].thumbnail = Endpoint.baseUrl + thread.posts[i].files![j].thumbnail
                            }
                        }
                    }
                    
                    
                    DispatchQueue.main.async {
                        completion(.success(thread))
                    }
            }
        }
    }
    
    func refreshThreads(board: String, completion: @escaping (Result<[ThreadDto], ApiError>) -> Void) {
        
        page = 0
    
        getMoreThreads(board: board, completion: completion)
    }
    
    func loadPostsFromThread(board: String, num: String, offset: Int, completion: @escaping (Result<[Post], ApiError>) -> Void) {
        
        request(endpoint: .posts(board: board, num: num, post: offset)) { (result: Result<[Post], ApiError>) in
            
            switch result {
                
                case .failure(let error):
                    completion(.failure(error))
                case .success(let posts):
                    
                    for i in 0 ..< posts.count {
                        
                        if posts[i].files != nil {
                            
                            for j in 0 ..< posts[i].files!.count {
                                
                                posts[i].files![j].path = Endpoint.baseUrl + posts[i].files![j].path
                                posts[i].files![j].thumbnail = Endpoint.baseUrl + posts[i].files![j].thumbnail
                            }
                        }
                    }
                    completion(.success(posts))
                }
        }
    }
}
