//
//  PostRouterInput.swift
//  iChan
//
//  Created by Enoxus on 02/04/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol PostRouterInput: AnyObject {
    
    func presentImage(index: Int, files: [File])
        
    func dismissPostModule()
    
    func dismissPostModuleAndPushThread(board: String, opNum: String, postNum: String?)
    
    func open(url: URL)
}
