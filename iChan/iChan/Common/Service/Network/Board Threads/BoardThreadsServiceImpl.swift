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
        
        request(endpoint: .board(id: board, page: page)) { (result: Result<ThreadResponse, ApiError>) in
            
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
                        
                        if let path = thread.posts[0].files?.first?.thumbnail {
                            thumbNail = Endpoint.baseUrl + path
                        }
                        
                        if let path = thread.posts[0].files?.first?.path {
                            file = Endpoint.baseUrl + path
                        }
                        
                        let dto = ThreadDto(number: thread.posts[0].num,
                                            filesCount: thread.filesCount,
                                            postsCount: thread.postsCount,
                                            date: thread.posts[0].date,
                                            thumbnail: thumbNail,
                                            file: file,
                                            text: thread.posts[0].comment,
                                            posterName: thread.posts[0].name)
                        
                        dtoArray.append(dto)
                    }
                    
                    DispatchQueue.main.async {
                        completion(.success(dtoArray))
                    }
            }
        }
        
        page += 1
    }
}
