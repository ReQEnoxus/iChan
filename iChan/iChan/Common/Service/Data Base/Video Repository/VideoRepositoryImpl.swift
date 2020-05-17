//
//  VideoRepositoryImpl.swift
//  iChan
//
//  Created by Enoxus on 13.05.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

class VideoRepositoryImpl: VideoRepository {
    
    /// crud service for realm interaction
    var crudService: CrudService!
    /// file manager that accesses device file system
    var fileManager: FileManagingService!
    
    func getVideo(by path: String, completion: @escaping (File?) -> Void) {
        
        crudService.get(type: FileModel.self, by: path) { [weak self] model in
            
            if let modelUnwrapped = model {
                
                let file = File(path: modelUnwrapped.path, thumbnail: modelUnwrapped.thumbnail, displayname: modelUnwrapped.displayName)
                
                
                file.fileData = self?.fileManager.get(by: modelUnwrapped.fileDataUrl ?? String())
                file.thumbnailData = self?.fileManager.get(by: modelUnwrapped.thumbnailDataUrl ?? String())
                
                DispatchQueue.main.async {
                    completion(file)
                }
            }
            else {
                DispatchQueue.main.async {
                    completion(.none)
                }
            }
        }
    }
}
