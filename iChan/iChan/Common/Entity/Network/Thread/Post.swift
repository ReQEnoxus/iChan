//
//  Post.swift
//  iChan
//
//  Created by Enoxus on 15/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import RealmSwift

/// post model that is obtained from API
class Post: Codable, RealmConvertible {
    
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
    
    func toRealmModel() -> Object {
        
        let model = PostModel()
        
        model.comment = comment
        model.name = name
        model.op = op
        model.num = num
        model.date = date
        model.repliesStr = repliesStr
        
        if let files = files {
            model.files.append(objectsIn: files.map({ $0.toRealmModel() as! FileModel }))
        }
        
        return model
    }
}

/// convenience structure for parsing
class File: Codable, RealmConvertible {
    
    var path: String
    var thumbnail: String
    var displayname: String
    var thumbnailData: Data?
    var fileData: Data?
    var localThumbnailUrl: String?
    var localFileUrl: String?
    
    var fileType: FileType {
        
        get {
            
            let pathExtension = (path as NSString).pathExtension
            
            let imageFormats = ["JPG", "JPEG", "PNG", "BMP", "GIF"]
            let videoFormats = ["WEBM", "MP4", "M4V"]
            
            if imageFormats.contains(pathExtension.uppercased()) {
                return .image
            }
            else if videoFormats.contains(pathExtension.uppercased()) {
                return .video
            }
            else {
                return .undefined
            }
        }
    }
    
    enum CodingKeys: String, CodingKey {
        
        case path = "path"
        case thumbnail = "thumbnail"
        case displayname = "displayname"
    }
    
    required init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        path = try container.decode(String.self, forKey: .path)
        thumbnail = try container.decode(String.self, forKey: .thumbnail)
        
        do {
            displayname = try container.decode(String.self, forKey: .displayname)
        }
        catch {
            displayname = UUID().uuidString
        }
    }
    
    init(path: String, thumbnail: String, displayname: String) {
        self.path = path
        self.thumbnail = thumbnail
        self.displayname = displayname
    }
    
    func toRealmModel() -> Object {
        
        let model = FileModel()
        
        model.path = URL(string: path)!.path
        model.thumbnail = thumbnail
        model.displayName = displayname
        model.fileDataUrl = localFileUrl
        model.thumbnailDataUrl = localThumbnailUrl
        
        return model
    }
}

enum FileType {
    
    case video
    case image
    case undefined
}
