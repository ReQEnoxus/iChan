//
//  ThreadSelectorRouterOutput.swift
//  iChan
//
//  Created by Enoxus on 11.05.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol ThreadSelectorRouterOutput: AnyObject {
    
    /// tells presenter that new thread was created
    /// - Parameter num: number of the OP-post
    func createdThread(with num: Int)
}
