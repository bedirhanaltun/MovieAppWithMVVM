//
//  NetworkManager.swift
//  MVVMLearning
//
//  Created by Bedirhan Altun on 14.10.2022.
//

import Foundation


class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    @discardableResult
    func download(url: URL, completion: @escaping (Result<Data, Error>) -> ()) -> URLSessionDataTask {
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            
            guard let data = data else {
                
                completion(.failure(URLError(.cannotDecodeRawData)))
                return
            }
            
            completion(.success(data))
            
        }
        dataTask.resume()
        
        return dataTask
    }
}
