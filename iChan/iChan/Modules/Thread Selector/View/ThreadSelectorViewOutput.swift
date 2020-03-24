//
//  ThreadSelectorViewOutput.swift
//  iChan
//
//  Created by Enoxus on 15/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol ThreadSelectorViewOutput: AnyObject {
    
    func loadMoreThreads()
    func initialSetup()
    func refreshRequested()
    func didPressedCollapse(on indexPath: IndexPath)
    func didSelectItem(at indexPath: IndexPath, collapsed: Bool)
}
