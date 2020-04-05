//
//  PostInteractorOutput.swift
//  iChan
//
//  Created by Enoxus on 02/04/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol PostInteractorOutput: AnyObject {
    
    /// tells presenter that url is checked and has certain type
    /// - Parameter type: type of url
    func didFinishCheckingUrl(type: UrlType)
}
