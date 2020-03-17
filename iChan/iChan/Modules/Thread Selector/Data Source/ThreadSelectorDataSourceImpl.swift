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
