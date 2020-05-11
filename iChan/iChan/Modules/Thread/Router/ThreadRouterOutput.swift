//
//  ThreadRouterOutput.swift
//  iChan
//
//  Created by Enoxus on 11.05.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation


protocol ThreadRouterOutput: AnyObject {
    
    /// tells presenter that thread should be refreshed because new post was added
    func refreshWithNewPost()
}
