//
//  PostRouter.swift
//  iChan
//
//  Created by Enoxus on 02/04/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import UIKit
import Lightbox
import SafariServices

class PostRouter: PostRouterInput {
    
    weak var view: UIViewController!
    
    func presentImage(index: Int, files: [File]) {
        
        var images = [LightboxImage]()
        
        for file in files {
            
            if let url = URL(string: file.path) {
                images.append(LightboxImage(imageURL: url, text: file.displayname))
            }
        }
        
        let controller = LightboxController(images: images, startIndex: index)
        
        controller.modalPresentationStyle = .fullScreen
        controller.dynamicBackground = true
        
        view.present(controller, animated: true)
    }
    
    func dismissPostModule() {
        view.dismiss(animated: true, completion: nil)
    }
    
    func open(url: URL) {
        
        let safariViewController = SFSafariViewController(url: url)
        safariViewController.preferredBarTintColor = .blackBg
        view.present(safariViewController, animated: true)
    }
}
