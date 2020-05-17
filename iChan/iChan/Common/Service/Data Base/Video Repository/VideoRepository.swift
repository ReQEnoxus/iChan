//
//  VideoRepository.swift
//  iChan
//
//  Created by Enoxus on 13.05.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol VideoRepository: AnyObject {
    
    /// tries to retrieve locally stored video by its url
    /// - Parameters:
    ///   - path: url of the video
    ///   - completion: action that should be performed after the data is retrieved
    func getVideo(by path: String, completion: @escaping (File?) -> Void)
}
