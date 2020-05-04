//
//  ThreadPostCellDelegate.swift
//  iChan
//
//  Created by Enoxus on 30/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol ThreadPostCellDelegate: AnyObject {
    
    /// tells delegate that particular image in collectionview was tapped
    /// - Parameter index: index of tapped image
    /// - Parameter files: array of collectionview content
    func didTapImage(index: Int, files: [File])
    
    /// tells delegate that user tapped some url
    /// - Parameter url: tapped url
    func didTapUrl(url: URL)
    
    /// tells delegate that user has tapped on some post's number
    /// - Parameter replyingTo: number of the tapped post
    func postNumberButtonPressed(replyingTo: String)
}
