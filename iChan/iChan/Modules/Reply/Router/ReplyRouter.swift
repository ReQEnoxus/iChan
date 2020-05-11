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
    
    var onPostCreated: (() -> Void)?
    
    func dismissReplyModule(postCreated: Bool) {
        view.dismiss(animated: true, completion: postCreated ? onPostCreated : .none)
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
