//
//  BoardSearchServiceImpl.swift
//  iChan
//
//  Created by Enoxus on 21.05.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

class BoardSearchServiceImpl: BoardSearchService {
    
    var cacheService: BoardCategoriesCacheService!
    
    func filterBoards(with query: String, completion: @escaping (BoardCategories) -> Void) {
        
        cacheService.current { boards in
            
            guard let boardsUnwrapped = boards else { return }
            
            if query.isEmpty {
                
                DispatchQueue.main.async {
                    completion(boardsUnwrapped)
                }
            }
            else {
                
                DispatchQueue.global(qos: .userInteractive).async {
                    
                    var categories = [[Board]]()
                    var names = [String]()
                    
                    for idx in .zero ..< boardsUnwrapped.categories.count {
                        
                        categories.append([])
                        names.append(boardsUnwrapped.categoryNames[idx])
                        
                        for boardIdx in .zero ..< boardsUnwrapped.categories[idx].count {
                            
                            let name = "\(boardsUnwrapped.categories[idx][boardIdx].id) - \(boardsUnwrapped.categories[idx][boardIdx].name)".lowercased()
                            
                            if name.contains(query.lowercased()) {
                                categories[categories.count - 1].append(boardsUnwrapped.categories[idx][boardIdx])
                            }
                        }
                        
                        if categories[categories.count - 1].isEmpty {
                            
                            categories.removeLast()
                            names.removeLast()
                        }
                    }
                    
                    let filtered = BoardCategories()
                    
                    filtered.categoryNames = names
                    filtered.categories = categories
                    
                    DispatchQueue.main.async {
                        completion(filtered)
                    }
                }
            }
        }
    }
}
