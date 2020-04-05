//
//  PostViewOutput.swift
//  iChan
//
//  Created by Enoxus on 02/04/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol PostViewOutput: AnyObject {
    
    func didTapImage(index: Int, files: [File])
    
    func didTapUrl(url: URL)
    
    func initialSetup()
    
    func dismissRequested()
}
