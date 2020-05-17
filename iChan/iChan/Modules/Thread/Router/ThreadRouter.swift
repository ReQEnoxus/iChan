//
//  ThreadRouter.swift
//  iChan
//
//  Created by Enoxus on 30/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import UIKit
import Lightbox
import SafariServices

class ThreadRouter: ThreadRouterInput {
    
    weak var view: UIViewController!
    weak var presenter: ThreadRouterOutput!
    
    //MARK: - Thread Router Input
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
    
    func open(url: URL) {
        
        if let scheme = url.scheme, scheme.isHttpScheme {
            
            let safariViewController = SFSafariViewController(url: url)
            safariViewController.preferredBarTintColor = .blackBg
            view.present(safariViewController, animated: true)
        }
    }
    
    func presentPostController(posts: [Post], board: String, postNum: String) {
        
        let vc = PostConfigurator.configureModule(posts: posts, board: board, num: postNum, parent: view)
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve

        view.present(vc, animated: true)
    }
    
    func pushAnotherThread(board: String, opNum: String, postNum: String?) {
        
        let vc = ThreadConfigurator.configureModule(board: board, num: opNum, postNum: postNum)
        view.navigationController?.pushViewController(vc, animated: true)
    }
    
    func presentReplyController(board: String, threadNum: String, replyingTo: String?) {
        
        let vc = ReplyConfigurator.configureModule(board: board, threadNum: threadNum, replyingTo: replyingTo) { [weak self] num in
            
            if let threadNumber = num {
                self?.presenter.refreshWithNewPost(num: threadNumber)
            }
        }
        view.present(vc, animated: true)
    }
}
