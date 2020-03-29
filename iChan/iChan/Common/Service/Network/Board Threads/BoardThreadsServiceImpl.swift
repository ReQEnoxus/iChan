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
                                            filesCount: thread.filesCount,
                                            postsCount: thread.postsCount,
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
    
    func refreshThreads(board: String, completion: @escaping (Result<[ThreadDto], ApiError>) -> Void) {
        
        page = 0
    
        getMoreThreads(board: board, completion: completion)
    }
}
