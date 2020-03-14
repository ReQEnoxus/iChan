//
//  BoardSelectorViewOutput.swift
//  iChan
//
//  Created by Enoxus on 08/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol BoardSelectorViewOutput: AnyObject {
    
    func didSelectRow(at indexPath: IndexPath)
    func initialSetup()
    func titleForHeaderInSection(section: Int) -> String?
    func pinItem(at: IndexPath)
    func unpinItem(at: IndexPath)
}
