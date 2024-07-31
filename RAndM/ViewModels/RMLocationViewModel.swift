//
//  RMLocationViewModel.swift
//  RAndM
//
//  Created by mac on 2024/7/31.
//

import Foundation

final class RMLocationViewModel {
    private var locations: [RMLocation] = []
    
    private var cellViewModel: [String] = []
    
    init() {
        
    }
    
    public func fetchLocations() {
        RMServer.shared.execute(.listLocationsRequest, expecting: String.self) { result in
            switch result {
            case .success(let success):
                break
            case .failure(let failure):
                break
            }
        }
        
    }
    
    private var hasMoreResults: Bool {
        return false
    }
}
