//
//  ThreadSelectorInteractorOutput.swift
//  iChan
//
//  Created by Enoxus on 15/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol ThreadSelectorInteractorOutput: AnyObject {
    
    func didFinishLoadingMoreThreads(threads: [ThreadDto])
    func didFinishRefreshingThreads(threads: [ThreadDto])
    func didFinishLoadingMoreWith(error: ApiError)
}
