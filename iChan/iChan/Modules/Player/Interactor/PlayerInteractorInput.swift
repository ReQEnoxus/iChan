//
//  PlayerInteractorInput.swift
//  iChan
//
//  Created by Enoxus on 19.04.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol PlayerInteractorInput: AnyObject {
    
    func togglePlayPause()
    
    func seekPosition(_ position: Float)
    
    func setDrawableForPlayer(_ drawable: UIView)
}
