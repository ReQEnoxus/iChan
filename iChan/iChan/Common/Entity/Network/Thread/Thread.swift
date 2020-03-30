//
//  Thread.swift
//  iChan
//
//  Created by Enoxus on 15/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

/// thread model that is obtained from API
class Thread: Codable {
    
    var filesCount: Int?
    var posts: [Post]
    var postsCount: Int?
    
    init(filesCount: Int?, posts: [Post], postsCount: Int?) {
        self.filesCount = filesCount
        self.posts = posts
        self.postsCount = postsCount
    }
    
    enum CodingKeys: String, CodingKey {
        
        case filesCount = "filesCount"
        case posts = "posts"
        case postsCount = "postsCount"
    }
    
    required init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        var filesCount: Int = 0
        
        if let filesCountString = try? container.decode(String.self, forKey: .filesCount), let intConverted = Int(filesCountString) {
            filesCount = intConverted
        }
        else if let filesCountInt = try? container.decode(Int.self, forKey: .filesCount) {
            filesCount = filesCountInt
        }
        
        self.filesCount = filesCount
        
        var postsCount: Int = 0
        
        if let postsCountString = try? container.decode(String.self, forKey: .postsCount), let intConverted = Int(postsCountString) {
            postsCount = intConverted
        }
        else if let postsCountInt = try? container.decode(Int.self, forKey: .postsCount) {
            postsCount = postsCountInt
        }
        
        self.postsCount = postsCount
        
        self.posts = try container.decode([Post].self, forKey: .posts)
    }
}
