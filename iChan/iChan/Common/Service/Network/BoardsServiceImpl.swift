//
//  BoardsServiceImpl.swift
//  iChan
//
//  Created by Enoxus on 07/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

class BoardsServiceImpl: BoardsService {
    
    func getBoards(complteion: @escaping (Result<BoardCategoriesResponse, ApiError>) -> Void) {
        request(endpoint: .boardCategories, completion: complteion)
    }
    
    var session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    convenience init() {
        
        let session = URLSession(configuration: .default)
        self.init(session: session)
    }
}
