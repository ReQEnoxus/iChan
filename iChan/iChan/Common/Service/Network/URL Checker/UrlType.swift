//
//  UrlType.swift
//  iChan
//
//  Created by Enoxus on 01/04/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

enum UrlType {
    
    case inner(board: String, num: String)
    case outer(url: URL)
}