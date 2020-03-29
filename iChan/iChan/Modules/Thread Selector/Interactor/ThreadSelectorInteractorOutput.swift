//
//  ThreadSelectorInteractorOutput.swift
//  iChan
//
//  Created by Enoxus on 15/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol ThreadSelectorInteractorOutput: AnyObject {
    
    /// tells presenter that new portion of threads is ready
    /// - Parameter threads: threads that arrived
    func didFinishLoadingMoreThreads(threads: [ThreadDto])
    
    /// tells presenter that refreshing is complete
    /// - Parameter threads: initial portion of threads
    func didFinishRefreshingThreads(threads: [ThreadDto])
    
    /// tells presenter that loading new portion of threads finished with error
    /// - Parameter error: error that occured during loading threads
    func didFinishLoadingMoreWith(error: ApiError)
    
    /// tells presenter that loading initial portion of threads finished with error
    /// - Parameter error: error that occured during loading threads
    func didFinishRefreshingWith(error: ApiError)
}
