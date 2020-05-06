//
//  Endpoint.swift
//  iChan
//
//  Created by Enoxus on 07/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

enum Endpoint {
    
    private static let httpsScheme = "https"
    private static let base = "2ch.hk"
    private static let categoriesPath = "/makaba/mobile.fcgi"
    private static let createPostPath = "/makaba/posting.fcgi"
    private static let categoriesParameterName = "task"
    private static let categoriesParameterValue = "get_boards"
    
    private static let postsPath = "/makaba/mobile.fcgi"
    private static let postsParameterName = "task"
    private static let postsParameterValue = "get_thread"
    private static let postsBoardParameterName = "board"
    private static let postsThreadParameterName = "thread"
    private static let postsPostParameterName = "post"
    private static let postsCodeParameterName = "code"
    private static let postsUsercodeParameterName = "usercode"
    private static let postsCaptchaTypeParameterName = "captcha_type"
    private static let postsCaptchaDefaultValueName = "invisible_recaptcha"
    private static let postsOptionsParameterName = "email"
    private static let postsNameParameterName = "name"
    private static let postsSubjectParameterName = "subject"
    private static let postsCommentParameterName = "comment"
    private static let postsCaptchaIdParameterName = "2chaptcha_id"
    private static let postsCaptchaIdDefaultValue = "6LdwXD4UAAAAAHxyTiwSMuge1-pf1ZiEL4qva_xu"
    private static let postsCaptchaResponseParameterName = "g-recaptcha-response"
    
    private static func boardPath(id: String, page: Int) -> String {
        return "/\(id)/\(page == 0 ? "index" : String(page)).json"
    }
    
    private static func threadPath(board: String, num: String) -> String {
        return "/\(board)/res/\(num).json"
    }
    
    private static func captchaSettingsPath(board: String) -> String {
        return "/api/captcha/settings/\(board)"
    }
    
    private static func captchaPublicKeyPath(for captchaType: String) -> String {
        return "/api/captcha/\(captchaType)/id"
    }
    
    public static var baseUrl: String {
        get {
            return "\(httpsScheme)://\(base)"
        }
    }
    
    enum Method: String {
        case GET = "GET"
        case POST = "POST"
    }
    
    case boardCategories
    case board(id: String, page: Int)
    case thread(board: String, num: String)
    case posts(board: String, num: String, post: Int)
    case createPost(board: String, num: String, options: String, comment: String, captcha: String)
    case captchaSettings(board: String)
    case captchaPublicKey(captchaType: String)
    
    var scheme: String {
        
        return Endpoint.httpsScheme
    }
    
    var host: String {
        
        return Endpoint.base
    }
    
    var path: String {
        
        switch self {
            
            case .boardCategories:
                return Endpoint.categoriesPath
            case .board(let id, let page):
                return Endpoint.boardPath(id: id, page: page)
            case .thread(let board, let num):
                return Endpoint.threadPath(board: board, num: num)
            case .posts:
                return Endpoint.postsPath
            case .createPost:
                return Endpoint.createPostPath
            case .captchaSettings(let board):
                return Endpoint.captchaSettingsPath(board: board)
            case .captchaPublicKey(let captchaType):
                return Endpoint.captchaPublicKeyPath(for: captchaType)
            }
    }
    
    var parameters: [URLQueryItem] {
        
        switch self {
            
            case .boardCategories:
                return [URLQueryItem(name: Endpoint.categoriesParameterName, value: Endpoint.categoriesParameterValue)]
            case .board:
                return []
            case .thread:
                return []
            case .posts(let board, let num, let post):
                return [URLQueryItem(name: Endpoint.postsParameterName, value: Endpoint.postsParameterValue),
                        URLQueryItem(name: Endpoint.postsBoardParameterName, value: board),
                        URLQueryItem(name: Endpoint.postsThreadParameterName, value: num),
                        URLQueryItem(name: Endpoint.postsPostParameterName, value: String(post))]
        case .createPost(let board, let num, let options, let comment, let captcha):
            return [.init(name: Endpoint.postsParameterName, value: Endpoint.postsPostParameterName),
                    .init(name: Endpoint.postsBoardParameterName, value: board),
                    .init(name: Endpoint.postsThreadParameterName, value: num),
                    .init(name: Endpoint.postsUsercodeParameterName, value: String()),
                    .init(name: Endpoint.postsCodeParameterName, value: String()),
                    .init(name: Endpoint.postsCaptchaTypeParameterName, value: Endpoint.postsCaptchaDefaultValueName),
                    .init(name: Endpoint.postsOptionsParameterName, value: options),
                    .init(name: Endpoint.postsNameParameterName, value: String()),
                    .init(name: Endpoint.postsSubjectParameterName, value: String()),
                    .init(name: Endpoint.postsCommentParameterName, value: comment),
                    .init(name: Endpoint.postsCaptchaIdParameterName, value: Endpoint.postsCaptchaIdDefaultValue),
                    .init(name: Endpoint.postsCaptchaResponseParameterName, value: captcha)]
            case .captchaSettings:
                return []
            case .captchaPublicKey:
                return []
        }
    }
    
    var method: String {
        
        switch self {
            
            case .boardCategories:
                return Method.GET.rawValue
            case .board:
                return Method.GET.rawValue
            case .thread:
                return Method.GET.rawValue
            case .posts:
                return Method.GET.rawValue
            case .createPost:
                return Method.POST.rawValue
            case .captchaSettings:
                return Method.GET.rawValue
            case .captchaPublicKey:
                return Method.GET.rawValue
        }
    }
}
