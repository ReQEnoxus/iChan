//
//  SettingsRouterInput.swift
//  iChan
//
//  Created by Enoxus on 12.05.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol SettingsRouterInput: AnyObject {
    
    /// tells router to navigate to a given settings page
    /// - Parameter route: route to navigate to
    func navigateToPage(_ route: Route)
}
