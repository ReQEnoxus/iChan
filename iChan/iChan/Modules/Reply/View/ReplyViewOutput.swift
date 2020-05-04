//
//  ReplyViewOutput.swift
//  iChan
//
//  Created by Enoxus on 04.05.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol ReplyViewOutput: AnyObject {
    
    func initialSetup()
    
    func cancelButtonPressed()
    
    func sendButtonPressed(message: Message)
}
