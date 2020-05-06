//
//  PostingFailReason.swift
//  iChan
//
//  Created by Enoxus on 06.05.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

/// basically a list of reasons why posting may actually fail
enum PostingFailReason {
    
    case recaptchaIsNotEnabled
    case requestError(_ error: ApiError)
    case serverSideError(description: String)
}
