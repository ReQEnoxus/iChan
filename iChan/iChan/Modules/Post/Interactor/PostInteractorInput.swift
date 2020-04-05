//
//  PostInteractorInput.swift
//  iChan
//
//  Created by Enoxus on 02/04/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol PostInteractorInput: AnyObject {
    
    /// tells interactor that user has tapped on url in textview
    /// - Parameter url: url that was tapped on
    func didTapUrl(url: URL)
}
