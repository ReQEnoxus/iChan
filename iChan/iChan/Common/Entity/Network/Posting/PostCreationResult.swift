//
//  PostCreationResult.swift
//  iChan
//
//  Created by Enoxus on 05.05.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

/// response of /makaba/posting.fcgi
struct PostCreationResult: Codable {
    
    let error: Int?
    let reason: String?
    let num: Int?
    let target: Int?
    
    enum CodingKeys: String, CodingKey {
        
        case error = "Error"
        case reason = "Reason"
        case num = "Num"
        case target = "Target"
    }
}
