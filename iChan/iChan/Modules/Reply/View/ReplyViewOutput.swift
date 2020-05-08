//
//  ReplyViewOutput.swift
//  iChan
//
//  Created by Enoxus on 04.05.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol ReplyViewOutput: AnyObject {
    
    /// tells presenter to perform initial setup on view
    func initialSetup()
    
    /// tells presenter that cancel button was pressed
    func cancelButtonPressed()
    
    /// tells presenter that send button was pressed
    /// - Parameters:
    ///   - options: options textfield content
    ///   - comment: message textview content
    func sendButtonPressed(options: String, comment: String)
    
    /// tells presenter that captcha was successfully validated
    /// - Parameter response: g-recaptcha-response
    func recaptchaValidated(with response: String)
    
    /// tells presenter that captcha validation has failed for some reason (this gets called if google captcha services are down)
    /// - Parameter error: error that occured during validation
    func recaptchaHasFailedToValidate(with error: Error)
    
    /// tells presenter that user has requested loading view dismissal
    func manualDismissOfLoadingViewRequested()
    
    func didLoadNewAttachment(_ attachment: PostAttachment)
    
    func didPressAddAttachmentButton()
}
