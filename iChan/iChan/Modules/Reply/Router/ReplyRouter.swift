//
//  ReplyRouter.swift
//  iChan
//
//  Created by Enoxus on 04.05.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

class ReplyRouter: ReplyRouterInput {
    
    weak var view: UIViewController!
    
    func dismissReplyModule() {
        view.dismiss(animated: true)
    }
}
