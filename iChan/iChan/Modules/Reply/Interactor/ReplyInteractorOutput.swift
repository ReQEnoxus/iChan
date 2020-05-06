//
//  ReplyInteractorOutput.swift
//  iChan
//
//  Created by Enoxus on 06.05.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol ReplyInteractorOutput: AnyObject {
    
    /// tells presenter that validation of the given public key is required
    /// - Parameter captchaKey: invisible recaptcha public key
    func performValidation(on captchaKey: String)
    
    /// tells presenter that posting has failed for some reason
    /// - Parameter reason: reason why posting has failed
    func postingFinishedWithError(reason: PostingFailReason)
    
    /// tells presenter that posting was successful
    func postingFinishedWithSuccess()
}
