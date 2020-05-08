//
//  PostAttachment.swift
//  iChan
//
//  Created by Enoxus on 08.05.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

/// struct that represents attachment and contains its data in binary form
struct PostAttachment {
    
    let id = UUID().uuidString
    let data: Data
    let name: String
}
