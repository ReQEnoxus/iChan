//
//  PlayerInteractorOutput.swift
//  iChan
//
//  Created by Enoxus on 19.04.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol PlayerInteractorOutput: AnyObject {
        
    func updateCurrentTime(time: VLCTime, position: Float)
}
