//
//  Extensions.swift
//  iChan
//
//  Created by Enoxus on 08/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func configureNavigationBar(largeTitleColor: UIColor, backgroundColor: UIColor, tintColor: UIColor, title: String, preferredLargeTitle: Bool) {
        
        if #available(iOS 13.0, *) {
            
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: largeTitleColor, .backgroundColor: UIColor.clear]
            navBarAppearance.titleTextAttributes = [.foregroundColor: largeTitleColor]
            navBarAppearance.backgroundColor = backgroundColor
            
            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.compactAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
            
            navigationController?.navigationBar.prefersLargeTitles = preferredLargeTitle
            navigationController?.navigationBar.isTranslucent = false
            navigationController?.navigationBar.tintColor = tintColor
            
            navigationItem.title = title
            
        } else {
            // Fallback on earlier versions
            navigationController?.navigationBar.barTintColor = backgroundColor
            navigationController?.navigationBar.tintColor = tintColor
            navigationController?.navigationBar.isTranslucent = false
            navigationItem.title = title
        }
    }
}

//MARK: - UITableView

extension UITableView {
    
    /// registers the given cell for the tableview
    /// - Parameter cell: cell to register
    func register(cell: UITableViewCell.Type) {
        self.register(cell, forCellReuseIdentifier: cell.nibName)
    }
}

//MARK: - UITableViewCell

extension UITableViewCell {
    
    /// returns the nib name for the cell
    static var nibName: String {
        
        get {
            return String(describing: self)
        }
    }
}

//MARK: - UIImage
extension UIImage {
    
    func resizeAndShift(newSize: CGSize, shiftLeft: CGFloat, shiftTop: CGFloat) -> UIImage {
        
        let renderer = UIGraphicsImageRenderer(size: newSize)
        let image = renderer.image { _ in
            self.draw(in: CGRect.init(origin: CGPoint.zero, size: newSize))
        }

        return shiftToCenter(shiftLeft: shiftLeft, shiftTop: shiftTop, image: image)
    }
    
    private func shiftToCenter(shiftLeft: CGFloat, shiftTop: CGFloat, image: UIImage) -> UIImage {
        
        return imageWithInset(insets: UIEdgeInsets(top: shiftTop, left: shiftLeft
            , bottom: 0, right: 0), image: image)
    }
    
    private func imageWithInset(insets: UIEdgeInsets, image: UIImage) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(
            CGSize(width: image.size.width + insets.left + insets.right,
                   height: image.size.height + insets.top + insets.bottom), false, image.scale)
        let origin = CGPoint(x: insets.left, y: insets.top)
        
        image.draw(at: origin)
        
        let imageWithInsets = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return imageWithInsets!
    }
    
}
