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
    
    func appendPosts(_ posts: [Post], completion: @escaping ([IndexPath]) -> Void) {
        
        var idxToInsert = [IndexPath]()
        
        for i in 0 ..< posts.count {
            idxToInsert.append(IndexPath(row: self.posts.count + i, section: 0))
        }
        
        self.posts += posts
        
        DispatchQueue.main.async {
            completion(idxToInsert)
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
