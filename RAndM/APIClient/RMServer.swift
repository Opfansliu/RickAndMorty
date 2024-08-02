//
//  RMServer.swift
//  RAndM
//
//  Created by mac on 2024/7/8.
//

import UIKit

final class RMServer {
    static let shared = RMServer()
    
    private let cacheManager = RMAPICacheManager()
    
    private init() {}
    
    enum RMServiceError: Error {
        
        case failedToCreateRequest
        case failedToGetData
        
    }
    
    public func execute<T: Codable>(
        _ request: RMRequest,
        expecting type: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        if let cacheData = cacheManager.cacheResponse(
            for: request.endpoint,
            url: request.url) {
            do {
                
                let result = try JSONDecoder().decode(type.self, from: cacheData)
//                print("using cached api response")
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
            
            return
            
        }
        
        guard let urlRequest = self.requests(from: request) else {
            completion(.failure(RMServiceError.failedToCreateRequest))
            return
        }
        let task = URLSession.shared.dataTask(with: urlRequest) {[weak self] data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? RMServiceError.failedToGetData))
                return
            }
            do {
                let result = try JSONDecoder().decode(type.self, from: data)
                self?.cacheManager.setCache(for: request.endpoint, url: request.url, data: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
            
        }
        task.resume()
        
    }
    
    private func requests(from rmRequest: RMRequest) -> URLRequest? {
        guard let url = rmRequest.url else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = rmRequest.httpMethod
        return request
        
    }


}
