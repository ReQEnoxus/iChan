//
//  Message.swift
//  iChan
//
//  Created by Enoxus on 06.05.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

/// class that encapsulates the data that is being sent to server
class Message {
    
    var options: String
    var comment: String
    var thread: String
    var board: String
    var captchaResponseKey: String?
    
    init(options: String, comment: String, thread: String, board: String, captchaResponseKey: String?) {
        self.options = options
        self.comment = comment
        self.thread = thread
        self.board = board
        self.captchaResponseKey = captchaResponseKey
    }
}
