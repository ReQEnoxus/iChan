//
//  PostingService.swift
//  iChan
//
//  Created by Enoxus on 05.05.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol PostingService: AnyObject {
        
    /// creates new post
    /// - Parameters:
    ///   - message: message to send
    ///   - completion: completion block that is called once request finishes successfully
    func createNewPost(message: Message, completion: @escaping (Result<PostCreationResult, ApiError>) -> Void)
    
    /// sends request to /api/captcha/settings/{board} and gets enabled captcha types
    /// - Parameter board: board for which settings are requested
    /// - Parameter completion: completion block that is called once data is ready
    func getCaptchaSettings(board: String, completion: @escaping (Result<CaptchaSettingsResponse, ApiError>) -> Void)
    
    /// sends request to /api/captcha/{captchaType}/id to retrieve the public key for given captcha type (mainly [in]visible recaptcha)
    /// - Parameter captchaType: captcha type
    func getCaptchaId(for captchaType: String, completion: @escaping (Result<CaptchaIdResponse, ApiError>) -> Void)
}
