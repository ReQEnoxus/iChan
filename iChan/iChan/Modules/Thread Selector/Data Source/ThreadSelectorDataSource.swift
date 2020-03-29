//
//  ThreadSelectorDataSource.swift
//  iChan
//
//  Created by Enoxus on 15/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import UIKit

protocol ThreadSelectorDataSource: AnyObject, UITableViewDataSource {
    
    /// array of thread models
    var threads: [ThreadDto] { get set }
    
    /// method that appends new portion of threads to array
    /// - Parameter threads: threads to append
    /// - Parameter completion: async block that ensures no duplicates are inserted into array, returns indexes of inserted rows
    func appendThreads(_ threads: [ThreadDto], completion: @escaping ([IndexPath]) -> Void)
}
