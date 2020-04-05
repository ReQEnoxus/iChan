//
//  UrlCheckerService.swift
//  iChan
//
//  Created by Enoxus on 01/04/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol UrlCheckerService {
    
    /// checks for the type of given url
    /// - Parameter url: url to check the type of
    func typeOf(url: URL) -> UrlType
}
