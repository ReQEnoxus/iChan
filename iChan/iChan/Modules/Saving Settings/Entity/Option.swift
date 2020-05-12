//
//  Option.swift
//  iChan
//
//  Created by Enoxus on 12.05.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation


class Option {
    
    var name: String
    var isSelected: Bool
    
    init(name: String, isSelected: Bool) {
        
        self.name = name
        self.isSelected = isSelected
    }
}
