//
//  Thread.swift
//  iChan
//
//  Created by Enoxus on 15/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import RealmSwift

/// thread model that is obtained from API
class Thread: Codable, RealmConvertible, UniquelyIdentifiable {
    
    var board: String = String()
    var filesCount: Int?
    var posts: [Post]
    var postsCount: Int?
    
    var id: String {
        return "\(board)-\(posts[0].num)"
    }
    
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
    
    func toRealmModel() -> Object {
        
        let model = ThreadModel()
        
        model.pkey = "\(board)-\(posts[0].num)"
                
        var calculatedFileCount = 0
        
        if filesCount == nil || filesCount == 0 {
            calculatedFileCount = posts.filter({ $0.files != nil && !$0.files!.isEmpty }).count
        }
        
        model.filesCount = calculatedFileCount
        model.postsCount = posts.count
        
        model.posts.append(objectsIn: posts.map({ $0.toRealmModel() as! PostModel }))
        
        return model
    }
    
    func toDto() -> ThreadDto {
        
        var thumbNail: String? = nil
        var file: String? = nil
        var fileName: String? = nil
        
        if let path = posts[0].files?.first?.thumbnail, !path.starts(with: Endpoint.baseUrl) {
            thumbNail = Endpoint.baseUrl + path
        }
        else if let path = posts[0].files?.first?.thumbnail {
            thumbNail = path
        }
        
        if let path = posts[0].files?.first?.path, !path.starts(with: Endpoint.baseUrl) {
            file = Endpoint.baseUrl + path
        }
        else if let path = posts[0].files?.first?.path {
            file = path
        }
        
        if let name = posts[0].files?.first?.displayname {
            fileName = name
        }
        
        var calculatedFileCount = 0
        
        if filesCount == nil || filesCount == 0 {
            calculatedFileCount = posts.filter({ $0.files != nil && !$0.files!.isEmpty }).count
        }
        
        let dto = ThreadDto(number: posts[0].num,
                            filesCount: filesCount == 0 || filesCount == nil ? calculatedFileCount : filesCount!,
                            postsCount: postsCount == 0 || postsCount == nil ? posts.count : postsCount!,
                            date: posts[0].date,
                            thumbnail: thumbNail,
                            file: file,
                            text: posts[0].comment,
                            posterName: posts[0].name,
                            fileName: fileName,
                            board: board)
        
        return dto
    }
}
