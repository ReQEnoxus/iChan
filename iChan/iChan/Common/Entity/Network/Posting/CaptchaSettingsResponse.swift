//
//  CaptchaSettingsResponse.swift
//  iChan
//
//  Created by Enoxus on 06.05.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

/// response of /api/captcha/settings/{board}
struct CaptchaSettingsResponse: Codable {
    
    let enabled: Int
    let types: [CaptchaType]
}
