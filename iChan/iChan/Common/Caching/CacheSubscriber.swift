//
//  CacheSubscriber.swift
//  iChan
//
//  Created by Enoxus on 11/04/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol CacheSubscriber: AnyObject {
    
    /// tells subscriber that cache has updated
    func cacheDidUpdate()
}
