//
//  AbstractApiClientService.swift
//  iChan
//
//  Created by Enoxus on 15/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

class AbstractApiClientService: ApiClient {
    
    var session: URLSession
    
    var decoder: JSONDecoder
    
    init(session: URLSession, decoder: JSONDecoder) {
        self.session = session
        self.decoder = decoder
    }
    
    convenience init() {
        
        let session = URLSession(configuration: .default)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        self.init(session: session, decoder: decoder)
    }
}
