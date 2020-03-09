//
//  BoardsService.swift
//  iChan
//
//  Created by Enoxus on 07/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol BoardsService: ApiClient {
    
    /// method that retrieves all the available boards
    /// - Parameter complteion: completion that is called when data is received
    func getBoards(complteion: @escaping (Result<BoardCategoriesResponse, ApiError>) -> Void)
}
