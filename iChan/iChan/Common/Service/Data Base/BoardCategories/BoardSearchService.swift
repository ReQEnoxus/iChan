//
//  BoardSearchService.swift
//  iChan
//
//  Created by Enoxus on 21.05.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol BoardSearchService: AnyObject {
    
    /// filters boards by given query
    /// - Parameters:
    ///   - query: query to search for
    ///   - completion: block that is called when filtering is finished
    func filterBoards(with query: String, completion: @escaping (BoardCategories) -> Void)
}
