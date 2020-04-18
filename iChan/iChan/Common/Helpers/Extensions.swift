//
//  Extensions.swift
//  iChan
//
//  Created by Enoxus on 08/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import UIKit

//MARK: - UIViewController
extension UIViewController {
    
    /// configures navbar
    /// - Parameter largeTitleColor: color of large titles
    /// - Parameter backgroundColor: bgcolor
    /// - Parameter tintColor: tint color
    /// - Parameter title: title of the view
    /// - Parameter preferredLargeTitle: should use large titles or now
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

//MARK: - UITableView
extension UICollectionView {
    
    /// registers the given cell for the tableview
    /// - Parameter cellClass: cell to register
    func register(cellClass: UICollectionViewCell.Type) {
        self.register(cellClass, forCellWithReuseIdentifier: cellClass.nibName)
    }
}

//MARK: - UITableViewCell
extension UICollectionViewCell {
    
    /// returns the nib name for the cell
    static var nibName: String {
        
        get {
            return String(describing: self)
        }
    }
}

//MARK: - UIImage
extension UIImage {
    
    /// resizes and shifts given image
    /// - Parameter newSize: new size
    /// - Parameter shiftLeft: left shift amount
    /// - Parameter shiftTop: top shift amount
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

//MARK: - UITextView
extension UITextView {
    
    /// sets html text to textview converting it to attributed string
    /// - Parameter htmlText: text containing html parts
    /// - Parameter fontSize: size of font
    func setHTMLFromString(htmlText: String, fontSize: CGFloat) {
        
        let classes = "<style> .unkfunc { color: #789922; } .spoiler { color: #7d7d7d; } </style>"
        
        let modifiedFont = String(format:" \(classes) <span style=\"font-family: '-apple-system', 'HelveticaNeue'; color: #FFFFFF; font-size: \(self.font?.pointSize ?? fontSize)\">%@</span>", htmlText)

        let attrStr = try! NSAttributedString(
            
            data: modifiedFont.data(using: .unicode, allowLossyConversion: true)!,
            options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue],
            documentAttributes: nil)

        self.attributedText = attrStr
    }
    
    var textHeight: CGFloat {
        
        let sizeThatFitsTextView = self.sizeThatFits(CGSize(width: self.frame.size.width, height: CGFloat(MAXFLOAT)))
        let heightOfText = sizeThatFitsTextView.height
        
        return heightOfText
    }
}

//MARK: - UILabel
extension UILabel {
    
    /// sets html text to textview converting it to attributed string
    /// - Parameter htmlText: text containing html parts
    /// - Parameter fontSize: size of font
    /// - Parameter hexColor: hex representation of text color
    func setHTMLFromString(htmlText: String, fontSize: CGFloat, hexColor: String) {
        
        let classes = "<style> .unkfunc { color: #789922; } .spoiler { color: #7d7d7d; } </style>"
        
        let modifiedFont = String(format:" \(classes) <span style=\"font-family: '-apple-system', 'HelveticaNeue'; color: \(hexColor) !important; font-size: \(self.font?.pointSize ?? fontSize)\">%@</span>", htmlText)
        
        let attrStr = try! NSAttributedString(
            
            data: modifiedFont.data(using: .unicode, allowLossyConversion: true)!,
            options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue],
            documentAttributes: nil)
        
        
        self.attributedText = attrStr
    }
}

//MARK: - String
extension String {
    
    func matches(for regex: String) -> [String] {

        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: self,
                                        range: NSRange(self.startIndex..., in: self))
            return results.map {
                String(self[Range($0.range, in: self)!])
            }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
    
    var isHttpScheme: Bool {
        return self == "http" || self == "https"
    }
}

//MARK: - Post
extension Post {
   
    func generateRepliesString() {
        
        let base = "<a href=\"applewebdata://reply/"
        let ending = "\">>>"
        self.repliesStr = "<i style=\"color: #909090;\"> Ответы: </i>\(replies.map({ base + $0 + ending + $0 }).joined(separator: " "))"
    }
}

//MARK: - UICollectionView
extension UICollectionView{
    
     func refreshLayout() {
          let oldLayout = collectionViewLayout as! UICollectionViewFlowLayout
          let newLayout = UICollectionViewFlowLayout()
          newLayout.estimatedItemSize = oldLayout.estimatedItemSize
          newLayout.footerReferenceSize = oldLayout.footerReferenceSize
          newLayout.headerReferenceSize = oldLayout.headerReferenceSize
          newLayout.itemSize = oldLayout.itemSize
          newLayout.minimumInteritemSpacing = oldLayout.minimumInteritemSpacing
          newLayout.minimumLineSpacing = oldLayout.minimumLineSpacing
          newLayout.scrollDirection = oldLayout.scrollDirection
          newLayout.sectionFootersPinToVisibleBounds = oldLayout.sectionFootersPinToVisibleBounds
          newLayout.sectionHeadersPinToVisibleBounds = oldLayout.sectionHeadersPinToVisibleBounds
          newLayout.sectionInset = oldLayout.sectionInset
          newLayout.sectionInsetReference = oldLayout.sectionInsetReference
          collectionViewLayout = newLayout
      }
}
