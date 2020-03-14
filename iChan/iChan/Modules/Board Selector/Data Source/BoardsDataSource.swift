//
//  BoardsDataSource.swift
//  iChan
//
//  Created by Enoxus on 08/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import UIKit

class BoardsDataSource: NSObject, BoardsDataSourceProtocol {
    
    var boardCategories: BoardCategories?
    
    weak var presenter: BoardsDataSourceOutput!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return boardCategories?.categories[section].count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: BoardTableViewCell.nibName, for: indexPath) as! BoardTableViewCell
        
        guard let board = boardCategories?.categories[indexPath.section][indexPath.row] else {
            fatalError("indexpath out of range")
        }
        
        cell.configure(with: "/\(board.id)/ - \(board.name)")
        cell.backgroundColor = .darkCellBg
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .darkCellBgSelected
        cell.selectedBackgroundView = backgroundView
        
        return cell
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return boardCategories?.categories.count ?? 0
    }
    
    func titleForHeaderInSection(section: Int) -> String? {
        
        return boardCategories?.categoryNames[section]
    }
    
    func pinItem(at: IndexPath) {
        // TODO: update cached copy
        
        if let boardToPin = boardCategories?.categories[at.section][at.row] {
            
            let sectionsCountBefore = boardCategories!.categories.count
            
            let pinSuccessful = boardCategories!.pin(board: boardToPin)
            
            let sectionsCountAfter = boardCategories!.categories.count
            
            if pinSuccessful {
                
                let sectionAdded = sectionsCountAfter > sectionsCountBefore
                
                let index = IndexPath(row: boardCategories!.categories[0].count - 1, section: 0)
                
                presenter.didFinishPinningItem(at: index, sectionCreated: sectionAdded)
            }
                
            else {
                presenter.didFinishPinningItem(at: nil, sectionCreated: false)
            }
        }
    }
    
    func unpinItem(at: IndexPath) {
        // TODO: update cached copy
        
        if let boardToUnpin = boardCategories?.categories[at.section][at.row] {
            
            let sectionsCountBefore = boardCategories!.categories.count
            
            let unpinSuccessful = boardCategories!.unpin(board: boardToUnpin)
            
            let sectionsCountAfter = boardCategories!.categories.count
            
            if unpinSuccessful {
                
                let sectionDeleted = sectionsCountAfter < sectionsCountBefore
                
                presenter.didFinishUnpinningItem(at: at, sectionDeleted: sectionDeleted)
            }
            else {
                presenter.didFinishUnpinningItem(at: nil, sectionDeleted: false)
            }
        }
    }
}
