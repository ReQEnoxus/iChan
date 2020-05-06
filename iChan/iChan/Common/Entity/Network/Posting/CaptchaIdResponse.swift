//
//  CaptchaIdResponse.swift
//  iChan
//
//  Created by Enoxus on 06.05.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

/// response of api/captcha/{type}/id
struct CaptchaIdResponse: Codable {
    
    let id: String
    let type: String
}
