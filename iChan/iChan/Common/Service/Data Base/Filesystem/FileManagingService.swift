//
//  FileManagingService.swift
//  iChan
//
//  Created by Enoxus on 13.05.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol FileManagingService: AnyObject {
    
    /// deletes a file on disc by given url
    /// - Parameter path: where target file is located
    func delete(from path: String?)
    
    /// saves a file
    /// - Parameters:
    ///   - object: binary data to save
    ///   - name: how to name the file
    func save(_ object: Data, name: String) throws -> String?
    
    /// returns an array of bytes from given url
    /// - Parameter url: where to obtain data from
    func get(by path: String) -> Data?
}
