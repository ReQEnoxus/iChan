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
    
    //MARK: - Router Input
    func presentImage(with attachment: AttachmentDto) {
        
        guard let imageUrl = URL(string: attachment.url) else { return }
        
        let image = LightboxImage(imageURL: imageUrl, text: attachment.displayName)
        let controller = LightboxController(images: [image], startIndex: 0)
        controller.modalPresentationStyle = .fullScreen
        controller.dynamicBackground = true
        
        view.present(controller, animated: true)
    }
    
    func pushThreadController(board: String, num: String, postNum: String?) {
        view.navigationController?.pushViewController(ThreadConfigurator.configureModule(board: board, num: num, postNum: postNum), animated: true)
    }
    
    func open(url: URL) {
        
        let safariViewController = SFSafariViewController(url: url)
        safariViewController.preferredBarTintColor = .blackBg
        view.present(safariViewController, animated: true)
    }
}
