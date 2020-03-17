//
//  Post.swift
//  iChan
//
//  Created by Enoxus on 15/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

struct Post: Codable {
    
    let comment: String
    let name: String
    let op: Int
    let num: String
    let date: String
    let files: [File]?
}

struct File: Codable {
    
    let path: String
    let thumbnail: String
}
