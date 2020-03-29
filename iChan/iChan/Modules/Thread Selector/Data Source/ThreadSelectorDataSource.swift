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
    
    var threads: [ThreadDto] { get set }
    
    func appendThreads(_ threads: [ThreadDto], completion: @escaping ([IndexPath]) -> Void)
}
