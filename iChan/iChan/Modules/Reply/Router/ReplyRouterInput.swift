//
//  ReplyRouterInput.swift
//  iChan
//
//  Created by Enoxus on 04.05.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol ReplyRouterInput: AnyObject {
    
    /// tells router to dismiss reply module
    /// - Parameter postCreated: number of created post
    func dismissReplyModule(postCreated: Int?)
    
    /// tells router to present image picker controller
    func presentImagePicker()
    
    /// tells router to dismiss image picker controller
    func dismissPicker()
}
