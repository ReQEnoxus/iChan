//
//  ReplyIneractorInput.swift
//  iChan
//
//  Created by Enoxus on 05.05.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol ReplyIneractorInput: AnyObject {
    
    /// tells interactor to prepare a new message
    /// - Parameters:
    ///   - board: target board
    ///   - thread: target thread
    ///   - options: options like email or sage
    ///   - comment: text of the message
    func createNewPost(board: String, thread: String, options: String, comment: String)
    
    /// tells interactor to send prepared post using given captcha code
    /// - Parameter captchaResponse: basically g-recaptcha-response
    func sendCurrentPost(with captchaResponse: String)
}
