//
//  PlayerRouter.swift
//  iChan
//
//  Created by Enoxus on 19.04.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import UIKit

class PlayerRouter: PlayerRouterInput {
    
    weak var view: UIViewController!
    
    func dismissPlayer() {
        view.dismiss(animated: false, completion: nil)
    }
}
