//
//  RMCharacterEpisodeCollectionViewCell.swift
//  RAndM
//
//  Created by mac on 2024/7/22.
//

import Foundation
protocol RMEpisodeDataRender {
    var name: String { get }
    var air_date: String { get }
    var episode: String { get }
}

final class RMCharacterEpisodeCollectionViewCellViewModel {
    private let episodeDataURL:URL?
    
    private var isFetching = false
    
    private var dataBlock: ((RMEpisodeDataRender) -> Void)?
    
    private var episode: RMEpisode? {
        didSet {
            guard let model = episode else {
                return
            }
            dataBlock?(model)
        }
    }
    //MARK: - init
    init(episodeDataURL: URL?) {
        self.episodeDataURL = episodeDataURL
    }
    //MARK: - Public
    public func registerForData( block: @escaping (RMEpisodeDataRender) -> Void) {
        self.dataBlock = block
        
    }
    
    
    public func fetchEpisode() {
        guard !isFetching else {
            if let model = episode {
                dataBlock?(model)
            }
            return
        }
        guard let url = episodeDataURL, let rmRequest = RMRequest(url: url) else { return }
        isFetching = true
        RMServer.shared.execute(rmRequest, expecting: RMEpisode.self) {[weak self] result in
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    self?.episode = model
                }
                
            case .failure(let failure):
                print(String(describing: failure.localizedDescription))
            }
        }
    }
}
