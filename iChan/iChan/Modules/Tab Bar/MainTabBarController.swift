//
//  MainTabBarController.swift
//  iChan
//
//  Created by Enoxus on 14/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    class Appearance {
        
        static let boardItemImage = "SF_bolt"
        static let historyItemImage = "SF_clock_fill"
        static let savedItemImage = "SF_square_stack_3d_up_slash_fill"
        static let settingsItemImage = "SF_line_horizontal_3_decrease_circle_fill"
        
        static let barItemSize: CGSize = CGSize(width: 25, height: 25)
        static let boardItemLeftOffset: CGFloat = 12
        static let boardItemTopOffset: CGFloat = 7
        static let historyItemLeftOffset: CGFloat = 0
        static let historyItemTopOffset: CGFloat = 7
        static let savedItemLeftOffset: CGFloat = 0
        static let savedItemTopOffset: CGFloat = 5
        static let settingsItemLeftOffset: CGFloat = 0
        static let settingsItemTopOffset: CGFloat = 13
    }
    
    func configure(with controllers: [UIViewController]) {
        
        tabBar.isTranslucent = false
        tabBar.barTintColor = .darkCellBg
        tabBar.tintColor = .orange
        
        let boardBarItem = UITabBarItem()
        boardBarItem.image = UIImage(named: Appearance.boardItemImage)?.resizeAndShift(newSize: Appearance.barItemSize, shiftLeft: Appearance.boardItemLeftOffset, shiftTop: Appearance.boardItemTopOffset)
        
        let historyBarItem = UITabBarItem()
        historyBarItem.image = UIImage(named: Appearance.historyItemImage)?.resizeAndShift(newSize: Appearance.barItemSize, shiftLeft: Appearance.historyItemLeftOffset, shiftTop: Appearance.historyItemTopOffset)
        
        let savedBarItem = UITabBarItem()
        savedBarItem.image = UIImage(named: Appearance.savedItemImage)?.resizeAndShift(newSize: Appearance.barItemSize, shiftLeft: Appearance.savedItemLeftOffset, shiftTop: Appearance.savedItemTopOffset)
        
        let settingsBarItem = UITabBarItem()
        settingsBarItem.image = UIImage(named: Appearance.settingsItemImage)?.resizeAndShift(newSize: Appearance.barItemSize, shiftLeft: Appearance.settingsItemLeftOffset, shiftTop: Appearance.settingsItemTopOffset)
        
        controllers[0].tabBarItem = boardBarItem
        controllers[1].tabBarItem = historyBarItem
        controllers[2].tabBarItem = savedBarItem
        controllers[3].tabBarItem = settingsBarItem
        
        viewControllers = controllers
    }
}
