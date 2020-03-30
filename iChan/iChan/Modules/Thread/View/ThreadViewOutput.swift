//
//  ThreadViewOutput.swift
//  iChan
//
//  Created by Enoxus on 30/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol ThreadViewOutput {
    
    /// tells presenter to perform initial setup
    func initialSetup()
    
    func loadThread()
}
