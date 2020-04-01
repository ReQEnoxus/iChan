//
//  UrlCheckerService.swift
//  iChan
//
//  Created by Enoxus on 01/04/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol UrlCheckerService {
    
    func typeOf(url: URL) -> UrlType
}
