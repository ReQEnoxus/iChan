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
        
    func configure(with post: Post)
}
