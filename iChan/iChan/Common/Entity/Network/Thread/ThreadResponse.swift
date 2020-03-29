//
//  ThreadResponse.swift
//  iChan
//
//  Created by Enoxus on 15/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

/// response that contains array of threads
struct ThreadResponse: Codable {
    
    let threads: [Thread]
}
