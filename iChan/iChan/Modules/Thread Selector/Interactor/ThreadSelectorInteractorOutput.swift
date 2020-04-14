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
    
    /// tells presenter that given url was checked and has a cetain type
    /// - Parameter type: type of the url
    func didFinishCheckingUrl(with type: UrlType)
    
    /// tells presenter that thread is saved
    func didFinishSavingThread()
    
    /// tells presenter that interactor has received notification from the persistent layer
    /// - Parameter new: new set of data
    /// - Parameter deletions: idx of deleted objects
    /// - Parameter insertions: idx of inserted object
    /// - Parameter modifications: idx of modified objects
    func didReceiveUpdateNotification(new: [ThreadDto], deletions: [IndexPath], insertions: [IndexPath], modifications: [IndexPath])
}
