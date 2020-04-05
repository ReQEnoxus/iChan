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
    weak var parentView: UIViewController!
    
    //MARK: - RouterInput
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
    
    func dismissPostModuleAndPushThread(board: String, opNum: String, postNum: String?) {
        
        view.dismiss(animated: true) { [weak self] in
            
            self?.parentView?.navigationController?.pushViewController(ThreadConfigurator.configureModule(board: board, num: opNum, postNum: postNum), animated: true)
        }
    }
    
    func open(url: URL) {
        
        let safariViewController = SFSafariViewController(url: url)
        safariViewController.preferredBarTintColor = .blackBg
        view.present(safariViewController, animated: true)
    }
}
