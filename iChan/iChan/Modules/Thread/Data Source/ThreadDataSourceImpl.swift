//
//  ThreadDataSourceImpl.swift
//  iChan
//
//  Created by Enoxus on 30/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import UIKit

class ThreadDataSourceImpl: NSObject, ThreadDataSource, ThreadPostCellDelegate {
    
    var posts: [Post] = []
    weak var presenter: ThreadDataSourceOutput!
    
    //MARK: - ThreadDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ThreadPostCell.nibName, for: indexPath) as! ThreadPostCell
        
        cell.configure(with: posts[indexPath.row], delegate: self)
        cell.backgroundColor = .darkCellBg
        
        return cell
    }
    
    func appendPosts(_ posts: [Post], completion: @escaping ([IndexPath], [IndexPath]) -> Void) {
        
        var idxToUpdate = Set<IndexPath>()
        let initialCount = self.posts.count
        
        let backingArray = self.posts + posts
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            
            guard let self = self else { return }
                        
            for i in 0 ..< posts.count {
                
                if posts[i].comment.contains("class=\"post-reply-link\"") {
                    
                    let matches = posts[i].comment.matches(for: ">>[0-9]+")
                    
                    for match in matches {
                        
                        let matchNum = match.replacingOccurrences(of: ">>", with: String())
                        
                        for j in 0 ..< backingArray.count {
                            
                            if backingArray[j].num == matchNum {
                                
                                if !backingArray[j].replies.contains(posts[i].num) {
                                    
                                    backingArray[j].replies.append(posts[i].num)
                                    idxToUpdate.insert(IndexPath(row: j, section: 0))
                                }
                            }
                        }
                    }
                }
            }
            
            idxToUpdate.forEach({ backingArray[$0.row].generateRepliesString() })
            
            var idxToInsert = [IndexPath]()
            
            for i in 0 ..< posts.count {
                idxToInsert.append(IndexPath(row: initialCount + i, section: 0))
            }
            
            self.posts = backingArray
            
            DispatchQueue.main.async {
                
                completion(idxToInsert, Array(idxToUpdate))
            }
        }
    }
    
    //MARK: - ThreadPostCellDelegate
    func didTapImage(index: Int, files: [File]) {
        presenter.didTapImage(index: index, files: files)
    }
    
    func didTapUrl(url: URL) {
        presenter.didTapUrl(url: url)
    }
}
