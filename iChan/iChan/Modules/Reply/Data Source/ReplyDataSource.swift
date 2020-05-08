//
//  ReplyDataSource.swift
//  iChan
//
//  Created by Enoxus on 08.05.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol ReplyDataSource: UITableViewDataSource {
    
    var attachments: [PostAttachment] { get set }
}
