//
//  ReplyViewInput.swift
//  iChan
//
//  Created by Enoxus on 04.05.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol ReplyViewInput: AnyObject {
    
    /// tells view to set initial text in the message text view
    /// - Parameter text: text to set
    func setInitialMessageText(_ text: String)
}
