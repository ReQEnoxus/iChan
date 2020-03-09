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
    
    enum Method: String {
        case GET = "GET"
    }
    
    case boardCategories
    
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
        }
    }
    
    var parameters: [URLQueryItem] {
        
        switch self {
            
            case .boardCategories:
                return [URLQueryItem(name: Endpoint.categoriesParameterName, value: Endpoint.categoriesParameterValue)]
        }
    }
    
    var method: String {
        
        switch self {
            
            case .boardCategories:
                return Method.GET.rawValue
        }
    }
}
