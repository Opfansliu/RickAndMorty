//
//  RMAPICacheManager.swift
//  RAndM
//
//  Created by mac on 2024/7/26.
//

import Foundation

final class RMAPICacheManager {
    private var cachesDictionary: [
        RMEndpoint: NSCache<NSString, NSData>
    ] = [:]
    
    private var cache = NSCache<NSString,NSData>()
    
    init() {
        setUpCache()
    }
    
    //MARK: - public
    public func cacheResponse(for endpoint: RMEndpoint, url: URL?) -> Data? {
        guard let targetCache = cachesDictionary[endpoint], let url = url else {
            return nil
        }
        
        let key = url.absoluteString as NSString
        return targetCache.object(forKey: key) as? Data
    }
    
    public func setCache(for endpoint: RMEndpoint, url: URL?, data: Data) {
        guard let targetCache = cachesDictionary[endpoint], let url = url else {
            return
        }
        
        let key = url.absoluteString as NSString
        targetCache.setObject(data as NSData, forKey: key)
        
    }
    
    //MARK: - private
    private func setUpCache() {
        RMEndpoint.allCases.forEach { endpoint in
            cachesDictionary[endpoint] = NSCache<NSString,NSData>()
        }
        
    }
}
