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
   
    var posts: [Post] { get set }
    
    /// method that appends new portion of posts  to array
    /// - Parameter posts: posts  to append
    /// - Parameter completion: async block that ensures no duplicates are inserted into array, returns indexes of inserted rows
    func appendPosts(_ posts: [Post], completion: @escaping ([IndexPath]) -> Void)
}
