//
//  ThreadDto.swift
//  iChan
//
//  Created by Enoxus on 15/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

/// Dto that used for configuring visual elements in thread selector module
class ThreadDto {
    
    let number: String
    let filesCount: Int
    let postsCount: Int
    let date: String
    let thumbnail: String?
    let file: String?
    var text: String
    let posterName: String
    let fileName: String?
    let board: String
    let thumbnailData: Data?
    let fileData: Data?
    var isCollapsed = false
    
    init(number: String, filesCount: Int, postsCount: Int, date: String, thumbnail: String?, file: String?, text: String, posterName: String, fileName: String?, board: String, thumbnailData: Data?, fileData: Data?) {
        self.number = number
        self.filesCount = filesCount
        self.postsCount = postsCount
        self.date = date
        self.thumbnail = thumbnail
        self.file = file
        self.text = text
        self.posterName = posterName
        self.fileName = fileName
        self.board = board
        self.thumbnailData = thumbnailData
        self.fileData = fileData
    }
}
