//
//  ThreadSelectorDataSourceImpl.swift
//  iChan
//
//  Created by Enoxus on 15/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import UIKit

class ThreadSelectorDataSourceImpl: NSObject, ThreadSelectorDataSource {
    
    var threads: [ThreadDto] = []
    
    func appendThreads(_ threads: [ThreadDto], completion: @escaping ([IndexPath]) -> Void) {
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            
            guard let self = self else { return }
            
            var threadsClean = [ThreadDto]()
            
            for thread in threads {
                
                if !self.threads.contains(where: {$0.number == thread.number}) {
                    threadsClean.append(thread)
                }
            }
            
            var idxToInsert = [IndexPath]()
            
            for i in 0 ..< threadsClean.count {
                idxToInsert.append(IndexPath(row: self.threads.count + i, section: 0))
            }
            
            self.threads += threadsClean
            
            DispatchQueue.main.async {
                completion(idxToInsert)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return threads.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ThreadTableViewCell.nibName, for: indexPath) as! ThreadTableViewCell
        
        cell.backgroundColor = .darkCellBg
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .darkCellBgSelected
        cell.selectedBackgroundView = backgroundView
        
        cell.configure(with: threads[indexPath.row])
        
        return cell
    }
}
