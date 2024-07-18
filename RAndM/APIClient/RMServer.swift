//
//  RMServer.swift
//  RAndM
//
//  Created by mac on 2024/7/8.
//

import UIKit

final class RMServer {
    static let shared = RMServer()
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
        guard let urlRequest = self.requests(from: request) else {
            completion(.failure(RMServiceError.failedToCreateRequest))
            return
        }
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? RMServiceError.failedToGetData))
                return
            }
            do {
                let result = try JSONDecoder().decode(type.self, from: data)
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
