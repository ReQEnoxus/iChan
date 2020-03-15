//
//  Thread.swift
//  iChan
//
//  Created by Enoxus on 15/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

struct Thread: Codable {
    
    let filesCount: Int
    let posts: [Post]
    let postsCount: Int
}