//
//  UrlCheckerServiceImpl.swift
//  iChan
//
//  Created by Enoxus on 01/04/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

class UrlCheckerServiceImpl: UrlCheckerService {
    
    private let innerScheme = "applewebdata"
    private let innerHost = "2ch.hk"
    
    func typeOf(url: URL) -> UrlType {
        
        if url.scheme == innerScheme || url.host == innerHost {
            
            let components = url.pathComponents
            let board = components[1]
            let num = components.last!.components(separatedBy: ".")[0]
            
            return .inner(board: board, num: num)
        }
        else {
            return .outer(url: url)
        }
    }
}
