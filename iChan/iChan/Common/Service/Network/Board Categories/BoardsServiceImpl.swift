//
//  BoardsServiceImpl.swift
//  iChan
//
//  Created by Enoxus on 07/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

class BoardsServiceImpl: AbstractApiClientService, BoardsService {
    
    func getBoards(complteion: @escaping (Result<BoardCategoriesResponse, ApiError>) -> Void) {
        request(endpoint: .boardCategories, completion: complteion)
    }
}
