//
//  Post.swift
//  iChan
//
//  Created by Enoxus on 15/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

/// post model that is obtained from API
class Post: Codable {
    
    var comment: String
    var name: String
    var op: Int
    var num: String
    var date: String
    var files: [File]?
    var replies: [String] = []
    var repliesStr = String()
    
    enum CodingKeys: String, CodingKey {
        
        case comment = "comment"
        case name = "name"
        case op = "op"
        case num = "num"
        case date = "date"
        case files = "files"
    }
    
    required init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.comment = try container.decode(String.self, forKey: .comment)
        self.name = try container.decode(String.self, forKey: .name)
        self.op = try container.decode(Int.self, forKey: .op)
        self.date = try container.decode(String.self, forKey: .date)
        self.files = try container.decode([File]?.self, forKey: .files)
        
        if let numInt = try? container.decode(Int.self, forKey: .num) {
            self.num = String(numInt)
        }
        else {
            self.num = try container.decode(String.self, forKey: .num)
        }
    }
    
    init(comment: String, name: String, op: Int, num: String, date: String, files: [File]?) {
        self.comment = comment
        self.name = name
        self.op = op
        self.num = num
        self.date = date
        self.files = files
    }
}

/// convenience structure for parsing
class File: Codable {
    
    var path: String
    var thumbnail: String
    var displayname: String
    
    init(path: String, thumbnail: String, displayname: String) {
        self.path = path
        self.thumbnail = thumbnail
        self.displayname = displayname
    }
}
