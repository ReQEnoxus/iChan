//
//  ReplyPresenter.swift
//  iChan
//
//  Created by Enoxus on 04.05.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

class ReplyPresenter: ReplyViewOutput, ReplyInteractorOutput {
    
    weak var view: ReplyViewInput!
    var router: ReplyRouterInput!
    var interactor: ReplyIneractorInput!
    
    var board: String!
    var threadNum: String!
    var replyingTo: String?
    
    //MARK: - View Output
    func initialSetup() {
        
        if let replyNumber = replyingTo {
            view.setInitialMessageText(">>\(replyNumber)\n")
        }
    }
    
    func cancelButtonPressed() {
        router.dismissReplyModule()
    }
    
    func sendButtonPressed(options: String, comment: String) {
        
        view.displayLoadingIndicator()
        interactor.createNewPost(board: board, thread: threadNum, options: options, comment: comment)
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
    
    func postingFinishedWithSuccess() {
        
        view.dismissLoadingView()
        router.dismissReplyModule()
    }
}
