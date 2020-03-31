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
    private static let categoriesParameterName = "task"
    private static let categoriesParameterValue = "get_boards"
    
    private static let postsPath = "/makaba/mobile.fcgi"
    private static let postsParameterName = "task"
    private static let postsParameterValue = "get_thread"
    private static let postsBoardParameterName = "board"
    private static let postsThreadParameterName = "thread"
    private static let postsPostParameterName = "post"
    
    private static func boardPath(id: String, page: Int) -> String {
        return "/\(id)/\(page == 0 ? "index" : String(page)).json"
    }
    
    private static func threadPath(board: String, num: String) -> String {
        return "/\(board)/res/\(num).json"
    }
    
    public static var baseUrl: String {
        get {
            return "\(httpsScheme)://\(base)"
        }
    }
    
    enum Method: String {
        case GET = "GET"
    }
    
    case boardCategories
    case board(id: String, page: Int)
    case thread(board: String, num: String)
    case posts(board: String, num: String, post: Int)
    
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
            case .posts(let board, let num, let post):
                return Endpoint.postsPath
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
        }
    }
}
