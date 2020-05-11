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
    /// - Parameter postCreated: true if new post was created
    func dismissReplyModule(postCreated: Bool)
    
    /// tells router to present image picker controller
    func presentImagePicker()
    
    /// tells router to dismiss image picker controller
    func dismissPicker()
}
