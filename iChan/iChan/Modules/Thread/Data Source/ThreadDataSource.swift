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
}
