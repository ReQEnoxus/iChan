//
//  PostingServiceImpl.swift
//  iChan
//
//  Created by Enoxus on 05.05.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

class PostingServiceImpl: AbstractApiClientService, PostingService {
    
    func createNewPost(message: Message, completion: @escaping (Result<PostCreationResult, ApiError>) -> Void) {
        
        request(endpoint: .createPost(board: message.board, num: message.thread, options: message.options, comment: message.comment, captcha: message.captchaResponseKey ?? String())) { (result: Result<PostCreationResult, ApiError>) in
            
            DispatchQueue.main.async {
                
                switch result {
                    
                    case .failure(let error):
                        completion(.failure(error))
                    case .success(let result):
                        completion(.success(result))
                }
            }
        }
    }
    
    func getCaptchaSettings(board: String, completion: @escaping (Result<CaptchaSettingsResponse, ApiError>) -> Void) {
        
        request(endpoint: .captchaSettings(board: board)) { (result: Result<CaptchaSettingsResponse, ApiError>) in
            
            DispatchQueue.main.async {
                
                switch result {
                    
                    case .failure(let error):
                        completion(.failure(error))
                    case .success(let result):
                        completion(.success(result))
                }
            }
        }
    }
    
    func getCaptchaId(for captchaType: String, completion: @escaping (Result<CaptchaIdResponse, ApiError>) -> Void) {
        
        request(endpoint: .captchaPublicKey(captchaType: captchaType)) { (result: Result<CaptchaIdResponse, ApiError>) in
            
            DispatchQueue.main.async {
                
                switch result {
                    
                    case .failure(let error):
                        completion(.failure(error))
                    case .success(let result):
                        completion(.success(result))
                }
            }
        }
    }
}
