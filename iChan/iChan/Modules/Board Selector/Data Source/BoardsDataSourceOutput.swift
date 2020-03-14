//
//  BoardsDataSourceOutput.swift
//  iChan
//
//  Created by Enoxus on 14/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol BoardsDataSourceOutput: AnyObject {
    
    /// tells the presenter that the item was pinned
    /// - Parameter index: index of pinned item
    /// - Parameter sectionCreated: was the section created
    func didFinishPinningItem(at index: IndexPath?, sectionCreated: Bool)
    /// tells the presenter that the item was unpinned
    /// - Parameter index: index of removed item
    /// - Parameter sectionDeleted: was the section deleted
    func didFinishUnpinningItem(at index: IndexPath?, sectionDeleted: Bool)
}
