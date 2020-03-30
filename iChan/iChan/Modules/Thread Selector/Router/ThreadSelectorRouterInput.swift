//
//  ThreadSelectorRouterInput.swift
//  iChan
//
//  Created by Enoxus on 29/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol ThreadSelectorRouterInput: AnyObject {
    
    /// tells router to present image with given url
    /// - Parameter attachment: attachment to be displayed fullscrren
    func presentImage(with attachment: AttachmentDto)
    
    func pushThreadController(board: String, num: String)
}
