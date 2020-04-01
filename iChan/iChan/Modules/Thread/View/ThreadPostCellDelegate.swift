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
    
    func didTapUrl(url: URL)
}