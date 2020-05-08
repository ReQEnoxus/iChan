//
//  ReplyDataSourceOutput.swift
//  iChan
//
//  Created by Enoxus on 08.05.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol ReplyDataSourceOutput: AnyObject {
    
    /// tells presenter that user wants to delete specific attachment
    /// - Parameter id: id of the attachment to be deleted
    func deleteButtonPressed(on id: String)
}
