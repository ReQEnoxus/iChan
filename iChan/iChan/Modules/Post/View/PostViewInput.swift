//
//  PostViewInput.swift
//  iChan
//
//  Created by Enoxus on 02/04/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import UIKit

protocol PostViewInput: AnyObject {
    
    /// configures the module with post
    /// - Parameter post: post that needs to be displayed
    func configure(with post: Post)
}
