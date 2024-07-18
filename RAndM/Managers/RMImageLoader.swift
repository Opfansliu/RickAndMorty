//
//  RMImageLoader.swift
//  RAndM
//
//  Created by mac on 2024/7/18.
//

import Foundation

final class RMImageLoader {
    static let shared = RMImageLoader()
    
    private init() {}
    private var imageDataCache = NSCache<NSString, NSData>()
    
    public func downloadImage(_ url:URL, completion:@escaping(Result<Data, Error>) -> Void) {
        if let data = self.imageDataCache.object(forKey: url.absoluteString as NSString) {
            completion((.success(data as Data)))
            return
        }
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) {[weak self] data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            
            let imageData = data as NSData
            let imageKey = url.absoluteString as NSString
            self?.imageDataCache.setObject(imageData, forKey: imageKey)
            
            completion(.success(data))
        }
        task.resume()
    }
}
