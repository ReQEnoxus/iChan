//
//  ApiClient.swift
//  iChan
//
//  Created by Enoxus on 07/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol ApiClient {
    
    /// http session instance
    var session: URLSession { get set }
    /// generic request method
    /// - Parameter endpoint: request endpoint
    /// - Parameter completion: completion that is called when the data is received
    func request<T: Codable>(endpoint: Endpoint, completion: @escaping (Result<T, ApiError>) -> Void)
}

extension ApiClient {
    
    func request<T: Codable>(endpoint: Endpoint, completion: @escaping (Result<T, ApiError>) -> Void) {
        
        var components = URLComponents()
        components.scheme = endpoint.scheme
        components.host = endpoint.host
        components.path = endpoint.path
        components.queryItems = endpoint.parameters
        
        guard let url = components.url else { return }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method
        
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            
            guard error == nil else {
                
                DispatchQueue.main.async {
                    completion(.failure(.requestFailed))
                }
                return
            }
            
            guard response != nil else {
                
                DispatchQueue.main.async {
                    completion(.failure(.responseUnsuccessful))
                }
                return
            }
            
            guard let data = data else {
                
                DispatchQueue.main.async {
                    completion(.failure(.invalidData))
                }
                return
            }
            
            do {

                let responseObject = try JSONDecoder().decode(T.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(responseObject))
                }
                return
            }
            catch {
                
                DispatchQueue.main.async {
                    completion(.failure(.jsonParsingFailure))
                }
                return
            }
        }
        
        dataTask.resume()
    }
}
