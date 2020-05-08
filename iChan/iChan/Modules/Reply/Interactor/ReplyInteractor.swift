//
//  ReplyInteractor.swift
//  iChan
//
//  Created by Enoxus on 05.05.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

class ReplyInteractor: ReplyIneractorInput {
    
    weak var presenter: ReplyInteractorOutput!
    
    var postingService: PostingService!
    var currentMessage: Message?
    
    let supportedCaptcha = "invisible_recaptcha"
    
    func createNewPost(board: String, thread: String, options: String, comment: String, images: [Data]) {
        
        postingService.getCaptchaSettings(board: board) { [weak self] result in
            
            DispatchQueue.main.async {
                
                switch result {
                    
                case .failure(let error):
                    self?.presenter.postingFinishedWithError(reason: .requestError(error))
                    
                case .success(let response):
                    
                    if response.types.contains(where: { $0.id == self?.supportedCaptcha }) {
                        
                        // invisible recaptcha is supported, creating message and then requesting recaptcha id for validation
                        self?.currentMessage = Message(options: options, comment: comment, thread: thread, board: board, captchaResponseKey: .none, images: images)
                        self?.requestCaptchaId()
                    }
                    else {
                        self?.presenter.postingFinishedWithError(reason: .recaptchaIsNotEnabled)
                    }
                }
            }
            
        }
    }
    
    func sendCurrentPost(with captchaResponse: String) {
        
        if let message = currentMessage {
            
            message.captchaResponseKey = captchaResponse
            
            postingService.createNewPost(message: message) { [weak self] result in
                
                DispatchQueue.main.async {
                    
                    switch result {
                        
                    case .failure(let error):
                        self?.presenter.postingFinishedWithError(reason: .requestError(error))
                    case .success(let postingResult):
                        
                        if let _ = postingResult.error, let reason = postingResult.reason {
                            
                            self?.presenter.postingFinishedWithError(reason: .serverSideError(description: reason))
                        }
                        else if postingResult.error == .none {
                            
                            self?.presenter.postingFinishedWithSuccess()
                        }
                    }
                }
            }
        }
    }
    
    private func requestCaptchaId() {
        
        postingService.getCaptchaId(for: supportedCaptcha) { [weak self]result in
            
            DispatchQueue.main.async {
                
                switch result {
                    
                case .failure(let error):
                    self?.presenter.postingFinishedWithError(reason: .requestError(error))
                case .success(let response):
                    self?.presenter.performValidation(on: response.id)
                }
            }
        }
    }
}
