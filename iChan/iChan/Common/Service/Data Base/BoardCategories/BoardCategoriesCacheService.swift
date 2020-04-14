//
//  BoardCategoriesCacheService.swift
//  iChan
//
//  Created by Enoxus on 09/04/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol BoardCategoriesCacheService: AnyObject {
    
    /// updates cached copy with a new instance
    /// - Parameter new: new instance of categories
    func update(_ new: BoardCategories)
    
    /// returns current cached copy if it exists, otherwise returns nil
    func current(completion: @escaping (BoardCategories?) -> Void)
    
    /// deletes current cached copy
    func delete()
    
    /// saves categories object to cache (called when there is no such object cached)
    /// - Parameter object: object to save
    func save(_ object: BoardCategories)
}
