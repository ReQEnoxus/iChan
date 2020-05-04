//
//  ReplyPresenter.swift
//  iChan
//
//  Created by Enoxus on 04.05.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

class ReplyPresenter: ReplyViewOutput {
    
    weak var view: ReplyViewInput!
    var router: ReplyRouterInput!
    
    var board: String!
    var threadNum: String!
    var replyingTo: String?
    
    func initialSetup() {
        
        if let replyNumber = replyingTo {
            
            if replyNumber == threadNum {
                view.setInitialMessageText(">>\(replyNumber)(OP)\n")
            }
            else {
                view.setInitialMessageText(">>\(replyNumber)\n")
            }
        }
    }
    
    func cancelButtonPressed() {
        router.dismissReplyModule()
    }
    
    func sendButtonPressed(message: Message) {
        print(message)
    }
}
