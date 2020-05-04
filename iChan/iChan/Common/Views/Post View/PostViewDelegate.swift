//
//  PostViewDelegate.swift
//  iChan
//
//  Created by Enoxus on 04.05.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol PostViewDelegate: AnyObject {
    
    /// tells delegate that user has tapped on the number of post
    func postNumberButtonPressed()
}
