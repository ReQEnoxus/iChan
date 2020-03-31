//
//  ThreadSelectorDataSourceImpl.swift
//  iChan
//
//  Created by Enoxus on 15/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import UIKit

class ThreadSelectorDataSourceImpl: NSObject, ThreadSelectorDataSource, ThreadTableViewCellDelegate {
    
    var threads: [ThreadDto] = []
    weak var presenter: ThreadSelectorDataSourceOutput!
    
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
        backgroundView.backgroundColor = .darkCellBg
        cell.selectedBackgroundView = backgroundView
        
        cell.configure(with: threads[indexPath.row], delegate: self)
        
        return cell
    }
    
    //MARK: - Thread Cell Delegate
    func didTapImage(with attachment: AttachmentDto) {
        presenter.didTapImage(with: attachment)
    }
    
    func didTapTextView(threadNum: String) {
        
        let row = threads.firstIndex(where: { $0.number == threadNum })
        
        if let rowUnwrapped = row {
            
            let indexPath = IndexPath(row: rowUnwrapped, section: 0)
            
            presenter.didTapTextView(at: indexPath)
        }
    }
}
