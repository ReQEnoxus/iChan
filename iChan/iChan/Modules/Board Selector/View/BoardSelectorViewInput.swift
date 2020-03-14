//
//  BoardSelectorViewInput.swift
//  iChan
//
//  Created by Enoxus on 08/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol BoardSelectorViewInput: AnyObject {
    
    func connectDataSource(_ dataSource: BoardsDataSourceProtocol)
    func refreshData()
    func pinItem(at index: IndexPath, sectionAdded: Bool)
    func unpinItem(at index: IndexPath, sectionDeleted: Bool)
}
