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
            case.thread(let board, let num):
                return Endpoint.threadPath(board: board, num: num)
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
        }
    }
}
