//
//  ThreadDataSource.swift
//  iChan
//
//  Created by Enoxus on 30/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import UIKit

protocol ThreadDataSource: UITableViewDataSource {
    
    /// array that contains all of the posts in current thread
    var posts: [Post] { get set }
}
