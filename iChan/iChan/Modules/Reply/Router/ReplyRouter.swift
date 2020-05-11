//
//  ReplyRouter.swift
//  iChan
//
//  Created by Enoxus on 04.05.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import UIKit

class ReplyRouter: ReplyRouterInput {
    
    weak var view: UIViewController!
    
    var picker: UIImagePickerController!
    
    var onPostCreated: ((Int) -> Void)?
    
    func dismissReplyModule(postCreated: Int?) {
        
        view.dismiss(animated: true, completion: { [weak self] in
            
            if let createdPost = postCreated, let onCreated = self?.onPostCreated {
                onCreated(createdPost)
            }
        })
    }
    
    func presentImagePicker() {
        
        if let delegate = view as? (UIImagePickerControllerDelegate & UINavigationControllerDelegate) {
            
            picker = UIImagePickerController()
            picker.allowsEditing = true
            picker.delegate = delegate
            picker.sourceType = .photoLibrary
            
            view.present(picker, animated: true)
        }
    }
    
    func dismissPicker() {
        
        picker.dismiss(animated: true)
    }
}
