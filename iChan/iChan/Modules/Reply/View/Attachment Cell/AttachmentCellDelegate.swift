//
//  AttachmentCellDelegate.swift
//  iChan
//
//  Created by Enoxus on 08.05.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol AttachmentCellDelegate: AnyObject {
    
    /// tells delegate that user has pressed delete button on specific attachment
    /// - Parameter attachment: attachment on which delete button was pressed
    func deleteButtonPressed(on attachment: PostAttachment)
}
