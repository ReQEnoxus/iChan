//
//  ReplyPresenter.swift
//  iChan
//
//  Created by Enoxus on 04.05.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

class ReplyPresenter: ReplyViewOutput, ReplyInteractorOutput, ReplyDataSourceOutput {
    
    weak var view: ReplyViewInput!
    var router: ReplyRouterInput!
    var interactor: ReplyIneractorInput!
    var dataSource: ReplyDataSource!
    
    var board: String!
    var threadNum: String!
    var replyingTo: String?
    
    //MARK: - View Output
    func initialSetup() {
        
        view.registerDataSourceForAttachmentsTable(dataSource)
        view.reloadAttachmentsData()
        
        if let replyNumber = replyingTo {
            view.setInitialMessageText(">>\(replyNumber)\n")
        }
    }
    
    func cancelButtonPressed() {
        router.dismissReplyModule(postCreated: .none)
    }
    
    func sendButtonPressed(options: String, comment: String) {
        
        view.displayLoadingIndicator()
        
        let images = dataSource.attachments.map({ $0.data })
        
        interactor.createNewPost(board: board, thread: threadNum, options: options, comment: comment, images: images)
    }
    
    func recaptchaValidated(with response: String) {
        interactor.sendCurrentPost(with: response)
    }
    
    func recaptchaHasFailedToValidate(with error: Error) {
        view.displayErrorMessage("Ошибка валидации капчи: \(error.localizedDescription)")
    }
    
    func manualDismissOfLoadingViewRequested() {
        view.dismissLoadingView()
    }
    
    func didLoadNewAttachment(_ attachment: PostAttachment) {
        
        let insertIndex = dataSource.attachments.count
        dataSource.attachments.append(attachment)
        router.dismissPicker()
        
        view.reloadAttachmentsData(deletions: [], insertions: [IndexPath(item: insertIndex, section: .zero)])
    }
    
    func didPressAddAttachmentButton() {
        router.presentImagePicker()
    }
    
    //MARK: - InteractorOutput
    func performValidation(on captchaKey: String) {
        view.validationRequested(on: captchaKey)
    }
    
    func postingFinishedWithError(reason: PostingFailReason) {
        
        var message: String
        
        switch reason {
            
            case .requestError(let error):
                message = "Ошибка сети: \(error.localizedDescription)"
            case .recaptchaIsNotEnabled:
                message = "На этой доске не работает Invisible Recaptcha, постинг невозможен :с"
            case .serverSideError(let description):
                message = "Ошибка сервера: \(description)"
        }
        
        view.displayErrorMessage(message)
    }
    
    func postingFinishedWithSuccess(num: Int) {
        
        view.dismissLoadingView()
        router.dismissReplyModule(postCreated: num)
    }
    
    //MARK: - Data Source Output
    func deleteButtonPressed(on id: String) {
        
        if let indexToDelete = dataSource.attachments.firstIndex(where: { $0.id == id }) {
            
            dataSource.attachments.remove(at: indexToDelete)
            view.reloadAttachmentsData(deletions: [IndexPath(item: indexToDelete, section: .zero)], insertions: [])
        }
    }
}
