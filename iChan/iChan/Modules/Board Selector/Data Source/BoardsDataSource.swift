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
    
    var favIsEmpty: Bool {
        
        if let boardCategories = boardCategories?.categories, !boardCategories.isEmpty {
            
            if boardCategories.first!.isEmpty {
                
                return true
            }
            
            else {
                
                return false
            }
        }
        else {
            return true
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var sectionIndex = section
        
        if favIsEmpty {
            sectionIndex = section + 1
        }
        
        return boardCategories?.categories[sectionIndex].count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: BoardTableViewCell.nibName, for: indexPath) as! BoardTableViewCell
        
        var sectionIndex = indexPath.section

        if favIsEmpty {
            sectionIndex = indexPath.section + 1
        }
        
        guard let board = boardCategories?.categories[sectionIndex][indexPath.row] else {
            fatalError("indexpath out of range")
        }
        
        cell.configure(with: "/\(board.id)/ - \(board.name)")
        cell.backgroundColor = .darkCellBg
        
        return cell
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if let categories =  boardCategories?.categories, !categories.isEmpty  {
            
            if categories.first!.isEmpty {
                return categories.count - 1
            }
            else {
                return categories.count
            }
        }
        else {
            return 0
        }
    }
    
    func titleForHeaderInSection(section: Int) -> String? {
        
        if let categories = boardCategories?.categories, let categoryNames = boardCategories?.categoryNames, !categories.isEmpty  {
            
            if categories.first!.isEmpty {
                return categoryNames[section + 1]
            }
            else {
                return categoryNames[section]
            }
        }
        else {
            return nil
        }
    }
    
    func pinItem(at: IndexPath) {
        // TODO: update cached copy
        var sectionIndex = at.section
        
        if favIsEmpty {
            sectionIndex = at.section + 1
        }
        
        if let categories = boardCategories?.categories, !categories[0].contains(where: { $0.id == categories[sectionIndex][at.row].id }) {
            boardCategories?.categories[0].append(categories[sectionIndex][at.row])
        }
    }
    
    func unpinItem(at: IndexPath) {
        // TODO: update cached copy
        if let categories = boardCategories?.categories {
            boardCategories?.categories[0].removeAll(where: { $0.id == categories[at.section][at.row].id })
        }
    }
}
