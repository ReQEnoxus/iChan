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
                
                if url.absoluteString.isValidVideoUrl, let thumbnailData = file.thumbnailData, let uiImage = UIImage(data: thumbnailData) {
                    images.append(LightboxImage(image: uiImage, text: file.displayname, videoURL: url))
                }
                else if url.absoluteString.isValidVideoUrl, let thumbnailUrl = URL(string: file.thumbnail) {
                    images.append(LightboxImage(imageURL: thumbnailUrl, text: file.displayname, videoURL: url))
                }
                else if let imageData = file.fileData, let uiImage = UIImage(data: imageData) {
                    images.append(LightboxImage(image: uiImage, text: file.displayname, videoURL: .none))
                }
                else {
                    images.append(LightboxImage(imageURL: url, text: file.displayname, videoURL: .none))
                }
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
        
        if let scheme = url.scheme, scheme.isHttpScheme {
            
            let safariViewController = SFSafariViewController(url: url)
            safariViewController.preferredBarTintColor = .blackBg
            view.present(safariViewController, animated: true)
        }
    }
    
    func presentReplyController(board: String, threadNum: String, replyingTo: String?) {
        
        let vc = ReplyConfigurator.configureModule(board: board, threadNum: threadNum, replyingTo: replyingTo, onPostCreated: .none)
        view.present(vc, animated: true)
    }
}
