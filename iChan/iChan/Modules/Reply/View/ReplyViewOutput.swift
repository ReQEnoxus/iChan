//
//  ReplyViewOutput.swift
//  iChan
//
//  Created by Enoxus on 04.05.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol ReplyViewOutput: AnyObject {
    
    /// tells presenter to perform initial setup on view
    func initialSetup()
    
    /// tells presenter that cancel button was pressed
    func cancelButtonPressed()
    
    /// tells presenter that send button was pressed
    /// - Parameter message: data in input fields
    func sendButtonPressed(message: Message)
}
