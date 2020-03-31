//
//  ThreadViewRouterInput.swift
//  iChan
//
//  Created by Enoxus on 30/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol ThreadRouterInput: AnyObject {
    
    /// tells router to present image
    /// - Parameter index: index of image in collectionview
    /// - Parameter files: attachments of the post
    func presentImage(index: Int, files: [File])
}
