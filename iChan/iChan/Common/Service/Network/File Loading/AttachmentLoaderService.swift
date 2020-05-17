//
//  AttachmentLoaderService.swift
//  iChan
//
//  Created by Enoxus on 13.05.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol AttachmentLoaderService: AnyObject {
    
    /// loads attachments according to passed strategy
    /// - Parameters:
    ///   - strategy: saving strategy
    ///   - posts: posts to load attachments from
    ///   - onFileLoaded: called when each individual attachment is downloaded, passes global progress as a parameter
    ///   - completion: called when everything is loaded
    func loadAttachments(strategy: SavingStrategy,
                         posts: [Post],
                         onFileLoaded: @escaping (Double) -> Void,
                         completion: @escaping ([Post], Bool) -> Void)
    
    /// tells attachment loader to stop current loading and delete already loaded files, takes action before next file is scheduled for download
    func interruptCurrentLoading()
}
