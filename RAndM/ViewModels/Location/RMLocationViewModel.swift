//
//  RMLocationViewModel.swift
//  RAndM
//
//  Created by mac on 2024/7/31.
//

import Foundation

protocol RMLocationViewModelDelete: AnyObject {
    func didFetchInitialLocations()
}

final class RMLocationViewModel {
    
    weak var delegate:RMLocationViewModelDelete?
    
    public var locations: [RMLocation] = [] {
        didSet {
            for location in locations {
                let cellViewModel = RMLocationTableViewCellViewModel(location: location)
                cellViewModels.append(cellViewModel)
            }
        }
    }
    
    public var cellViewModels: [RMLocationTableViewCellViewModel] = []
    
    private var info: RMGetAllLocationsResponse.Info?
    
    init() {
        
    }
    
    public func location(at index:Int) -> RMLocation? {
        guard index < locations.count else {
            return nil
        }
        return locations[index]
    }
    
    public func fetchLocations() {
        RMServer.shared.execute(.listLocationsRequest, expecting: RMGetAllLocationsResponse.self) {[weak self] result in
            switch result {
            case .success(let model):
                self?.info = model.info
                self?.locations = model.results
                DispatchQueue.main.async {
                    self?.delegate?.didFetchInitialLocations()
                }
            case .failure(_):
                break
            }
        }
        
    }
    
    private var hasMoreResults: Bool {
        return false
    }
    

}
