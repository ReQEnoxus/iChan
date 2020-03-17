//
//  BoardSelectorRouter.swift
//  iChan
//
//  Created by Enoxus on 08/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import UIKit

class BoardSelectorRouter: BoardSelectorRouterProtocol {
    
    weak var view: UIViewController!
    
    func pushToThreadSelector(board: Board) {
        
        view.navigationController?.pushViewController(ThreadSelectorConfigurator.configureModule(board: board), animated: true)
    }
}
