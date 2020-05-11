//
//  ThreadSelectorRouter.swift
//  iChan
//
//  Created by Enoxus on 29/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import UIKit
import Lightbox
import SafariServices

class ThreadSelectorRouter: ThreadSelectorRouterInput {
    
    weak var view: UIViewController!
    weak var presenter: ThreadSelectorRouterOutput!
    
    //MARK: - Router Input
    func presentImage(with attachment: AttachmentDto) {
        
        guard let imageUrl = URL(string: attachment.url) else { return }
        
        let image: LightboxImage!
        
        if imageUrl.absoluteString.isValidVideoUrl, let thumbnailUrl = URL(string: attachment.thumbnail) {
            image = LightboxImage(imageURL: thumbnailUrl, text: attachment.displayName, videoURL: imageUrl)
        }
        else {
            image = LightboxImage(imageURL: imageUrl, text: attachment.displayName, videoURL: .none)
        }
        
        let controller = LightboxController(images: [image], startIndex: 0)
        controller.modalPresentationStyle = .fullScreen
        controller.dynamicBackground = true
        
        view.present(controller, animated: true)
    }
    
    func pushThreadController(board: String, num: String, postNum: String?) {
        view.navigationController?.pushViewController(ThreadConfigurator.configureModule(board: board, num: num, postNum: postNum), animated: true)
    }
    
    func open(url: URL) {
        
        if let scheme = url.scheme, scheme.isHttpScheme {
            
            let safariViewController = SFSafariViewController(url: url)
            safariViewController.preferredBarTintColor = .blackBg
            view.present(safariViewController, animated: true)
        }
    }
    
    func presentReplyController(board: String, threadNum: String, replyingTo: String?) {
        
        print(presenter)
        let vc = ReplyConfigurator.configureModule(board: board, threadNum: threadNum, replyingTo: replyingTo) { [weak self] num in
            
            if let threadNumber = num {
                self?.presenter.createdThread(with: threadNumber)
            }
        }
        view.present(vc, animated: true)
    }
}
