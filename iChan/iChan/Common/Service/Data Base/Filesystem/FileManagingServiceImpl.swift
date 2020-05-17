//
//  FileManagingServiceImpl.swift
//  iChan
//
//  Created by Enoxus on 13.05.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

class FileManagingServiceImpl: FileManagingService {
    
    /// file manager that accesses device file system
    private var fileManager = FileManager.default
    
    func delete(from path: String?) {
        
        guard let path = path else { return }
        
        let documentsDirectory = try? fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: .none, create: false)
        
        guard let documents = documentsDirectory else { return }
        
        let deletionPath = documents.appendingPathComponent(path).path
        
        try? fileManager.removeItem(atPath: deletionPath)
        
    }
    
    func save(_ object: Data, name: String) -> String? {
        
        do {
            
            let documentsDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: .none, create: false)
            
            let targetUrl = documentsDirectory.appendingPathComponent(name)
            
            try object.write(to: targetUrl, options: .atomicWrite)
            
            return targetUrl.lastPathComponent
        }
        catch {
            return .none
        }
    }
    
    func get(by path: String) -> Data? {
        
        let documentsDirectory = try? fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: .none, create: false)
        
        guard let documents = documentsDirectory else { return .none }
        
        return try? Data(contentsOf: URL(fileURLWithPath: path, relativeTo: documents))
    }
}
