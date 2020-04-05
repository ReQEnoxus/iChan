//
//  UrlType.swift
//  iChan
//
//  Created by Enoxus on 01/04/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

enum UrlType {
    
    case innerReply(num: String)
    case inner(board: String, opNum: String, postNum: String?)
    case outer(url: URL)
}
