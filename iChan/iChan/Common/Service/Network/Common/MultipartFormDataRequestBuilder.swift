//
//  MultipartFormDataRequestBuilder.swift
//  iChan
//
//  Created by Enoxus on 05.05.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

class MultipartFormDataRequestBuilder {
    
    /// builds valid multipart/formdata request
    /// - Parameters:
    ///   - queryItems: parameters i.e body
    ///   - targetUrl: destination
    /// - Returns: built urlrequest
    class func build(from queryItems: [URLQueryItem], targetUrl: URL) -> URLRequest {
        
        var request = URLRequest(url: targetUrl)
        request.httpMethod = "POST"
        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-type")
        
        let body = NSMutableData()
        let boundaryPrefix = "--\(boundary)\r\n"
        
        for queryItem in queryItems {
            
            body.appendString(boundaryPrefix)
            body.appendString("Content-Disposition: form-data; name=\"\(queryItem.name)\"\r\n\r\n")
            body.appendString("\(queryItem.value ?? String())\r\n")
        }
        
        body.appendString("--".appending(boundary.appending("--")))
        
        request.httpBody = body as Data
        
        return request
    }
}
