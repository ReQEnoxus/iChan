//
//  AttachmentLoaderServiceImpl.swift
//  iChan
//
//  Created by Enoxus on 13.05.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

class AttachmentLoaderServiceImpl: AttachmentLoaderService {
    
    var fileManagingService: FileManagingService!
    
    private var isInterrupted = false
    private var downloadQueue: OperationQueue?
    
    func loadAttachments(strategy: SavingStrategy, posts: [Post], onFileLoaded: @escaping (Double) -> Void, completion: @escaping ([Post], Bool) -> Void) {
        
        var totalCount = Double.zero
        
        if strategy == .textOnly {
            
            DispatchQueue.main.async {
                
                completion(posts, true)
                return
            }
        }
        else {
            
            downloadQueue = OperationQueue()
            downloadQueue?.maxConcurrentOperationCount = 1
            downloadQueue?.qualityOfService = .userInteractive
            
            let currentDownload = BlockOperation()
            
            currentDownload.addExecutionBlock { [weak self] in
                
                var saved = [String]()
                
                if strategy == .textAndPics {
                    posts.forEach({ totalCount += Double($0.files?.filter({ $0.fileType == .image }).count ?? .zero) })
                }
                else if strategy == .textAndAllAttachments {
                    posts.forEach({ totalCount += Double($0.files?.count ?? .zero) })
                }
                
                var count = Double.zero
                
                for i in .zero ..< posts.count {
                    
                    guard let _ = posts[i].files else { continue }
                    
                    for fileIndex in .zero ..< posts[i].files!.count {
                        
                        if currentDownload.isCancelled {
                            
                            DispatchQueue.main.async {
                                completion([], false)
                            }
                            
                            for path in saved {
                                self?.fileManagingService.delete(from: path)
                            }
                            
                            return
                        }
                        
                        if let thumbnailUrl = URL(string: posts[i].files![fileIndex].thumbnail), let fileUrl = URL(string: posts[i].files![fileIndex].path) {
                            
                            if strategy == .textAndPics, posts[i].files![fileIndex].fileType != .image {
                                continue
                            }
                            
                            let thumbnailData = try? Data(contentsOf: thumbnailUrl)
                            let fileData = try? Data(contentsOf: fileUrl)
                            
                            do {
                                guard let thumbnailData = thumbnailData, let fileData = fileData else { break }
                                
                                posts[i].files![fileIndex].localThumbnailUrl = try self?.fileManagingService.save(thumbnailData, name: thumbnailUrl.lastPathComponent)
                                posts[i].files![fileIndex].localFileUrl = try self?.fileManagingService.save(fileData, name: fileUrl.lastPathComponent)
                                
                                saved.append(thumbnailUrl.lastPathComponent)
                                saved.append(fileUrl.lastPathComponent)
                            }
                            catch(let error) {
                                print(error.localizedDescription)
                            }
                            
                            if count < totalCount {
                                count += 1
                            }
                            
                            DispatchQueue.main.async {
                                onFileLoaded((count / totalCount).truncatingRemainder(dividingBy: 1))
                            }
                        }
                    }
                }
                    
                DispatchQueue.main.async {
                    completion(posts, true)
                }
            }
            
            downloadQueue?.addOperation(currentDownload)
        }
    }
    
    func interruptCurrentLoading() {
        
        if !isInterrupted {
            
            isInterrupted.toggle()
            downloadQueue?.cancelAllOperations()
            isInterrupted.toggle()
        }
    }
}
