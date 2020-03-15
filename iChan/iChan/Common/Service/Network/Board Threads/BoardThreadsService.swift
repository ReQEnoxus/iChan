//
//  BoardThreadsService.swift
//  iChan
//
//  Created by Enoxus on 15/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol BoardThreadsService: ApiClient {
    
    /// gets the new portion of threads from server
    /// - Parameter completion: block that is called when the data is received
    /// - Parameter board: board that the threads are requested from
    func getMoreThreads(board: String, completion: @escaping (Result<[ThreadDto], ApiError>) -> Void)
}
