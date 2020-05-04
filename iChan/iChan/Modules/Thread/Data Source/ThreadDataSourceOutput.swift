//
//  ThreadDataSourceOutput.swift
//  iChan
//
//  Created by Enoxus on 30/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol ThreadDataSourceOutput: AnyObject {
    
    /// tells presenter that user has tapped the image
    /// - Parameter index: index of the tapped image in collectionview
    /// - Parameter files: all of the attachments in the post
    func didTapImage(index: Int, files: [File])
    
    /// tells presenter that user has tapped the url inside of the post cell
    /// - Parameter url: tapped url
    func didTapUrl(url: URL)
    
    /// tells presenter that user has tapped some post's number
    /// - Parameter replyingTo: number that user has tapped on
    func postNumberButtonPressed(replyingTo: String)
}
