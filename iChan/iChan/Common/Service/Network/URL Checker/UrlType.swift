//
//  UrlType.swift
//  iChan
//
//  Created by Enoxus on 01/04/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

/// types of urls that may be present in application
enum UrlType {
    
    case innerReply(num: String)
    case inner(board: String, opNum: String, postNum: String?)
    case outer(url: URL)
}
