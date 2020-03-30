//
//  ThreadViewInteractorInput.swift
//  iChan
//
//  Created by Enoxus on 30/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol ThreadInteractorInput: AnyObject {
    
    func loadThread(board: String, num: String)
}
