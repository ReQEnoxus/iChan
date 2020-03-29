//
//  ThreadTableViewCellDelegate.swift
//  iChan
//
//  Created by Enoxus on 29/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol ThreadTableViewCellDelegate: AnyObject {
    
    /// tells delegate that particular image was tapped by user
    /// - Parameter attachment: attachment to be displayed fullscrren
    func didTapImage(with attachment: AttachmentDto)
}
