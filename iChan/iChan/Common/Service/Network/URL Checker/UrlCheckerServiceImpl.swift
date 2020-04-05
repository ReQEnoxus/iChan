//
//  UrlCheckerServiceImpl.swift
//  iChan
//
//  Created by Enoxus on 01/04/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

class UrlCheckerServiceImpl: UrlCheckerService {
    
    private let innerScheme = "applewebdata"
    private let innerHost = "2ch.hk"
    private let replyComponent = "reply"
    private let replySeparator = "#"
    private let extensionSeparator = "."
    private let urlSeparator = "/"
    
    func typeOf(url: URL) -> UrlType {
                
        if url.scheme == innerScheme || url.host == innerHost {
            
            let components = url.pathComponents
            let board = components[1]
            let num = components.last!.components(separatedBy: extensionSeparator)[0]
            
            if url.absoluteString.contains(replyComponent) {
                
                return .innerReply(num: num)
            }
            
            if url.absoluteString.contains(replySeparator) {
                
                let postNum = url.absoluteString.components(separatedBy: replySeparator)[1]
                let opNum = url.absoluteString.components(separatedBy: replySeparator)[0].components(separatedBy: urlSeparator).last!.components(separatedBy: extensionSeparator)[0]
                
                return .inner(board: board, opNum: opNum, postNum: postNum)
            }
            else {
                return .inner(board: board, opNum: num, postNum: nil)
            }
        }
        else {
            return .outer(url: url)
        }
    }
}
