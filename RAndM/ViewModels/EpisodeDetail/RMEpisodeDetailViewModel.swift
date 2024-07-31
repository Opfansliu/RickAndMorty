//
//  RMEpisodeDetailModel.swift
//  RAndM
//
//  Created by mac on 2024/7/26.
//

import Foundation

protocol RMEpisodeDetailViewModelDelete: AnyObject {
    func didFetchEpisodeDetails()
}

final class RMEpisodeDetailViewModel {
    private let endpointUrl: URL?
    
    public weak var delegate: RMEpisodeDetailViewModelDelete?
    
    public var dataTuple: (episode: RMEpisode, characters:[RMCharacter])? {
        didSet {
            createCellViewModels()
            delegate?.didFetchEpisodeDetails()
        }
    }
    
    enum SelectionType {
        case information(viewModels: [RMEpisodeInfoCollectionViewCellViewModel])
        case characters(viewModels: [RMCharacterListViewCellViewModel])
    }
    //对外只读
    public private(set) var cellViewModels: [SelectionType] = []
    
    //MARK: - init
    
    init(endpointUrl: URL?) {
        self.endpointUrl = endpointUrl
        fetchEpisodeData()
    }
    
    //MARK: - public
    
    public func character(at index: Int) -> RMCharacter? {
        guard let dataTuple = dataTuple else { return nil }
        return dataTuple.characters[index]
    }

    
    //MARK: - private
    
    public func createCellViewModels() {
        guard let dataTuple = dataTuple else { return }
        let episode = dataTuple.episode
        let characters = dataTuple.characters
        var createdString = episode.created
        if let createdData = RMCharacterInfoCollectionViewCellViewModel.dataFormatter.date(from: episode.created) {
            createdString = RMCharacterInfoCollectionViewCellViewModel.shortDateFormatter.string(from: createdData)
        }
        
        cellViewModels = [
            .information(viewModels: [
                .init(title: "Episode name", value: episode.name),
                .init(title: "Air Data", value: episode.air_date),
                .init(title: "Episode", value: episode.episode),
                .init(title: "Created", value: createdString)
            ]),
            .characters(viewModels: characters.compactMap({ character in
                return RMCharacterListViewCellViewModel(
                    characterName: character.name,
                    characterStatus: character.status,
                    characterImageUrl: URL(string: character.image)
                )
            }))
        ]
        
    }
    
    public func fetchEpisodeData() {
        guard let endpointUrl = endpointUrl else { return }
        guard let request = RMRequest(url: endpointUrl) else {
            return
        }
        
        RMServer.shared.execute(request, expecting: RMEpisode.self) {[weak self] result in
            switch result {
            case .success(let model):
                self?.fetchRelatedCharacters(episode: model)
            case .failure(let failure):
                print(String(describing: failure))
            }
        }
    }
    private func fetchRelatedCharacters(episode: RMEpisode) {
        let requests = episode.characters.compactMap ({
            return URL(string: $0)
        }).compactMap({
            return RMRequest(url: $0)
        })
        
        let group = DispatchGroup()
        var characters = [RMCharacter]()
        
        for request in requests {
            group.enter()
            RMServer.shared.execute(request, expecting: RMCharacter.self) { result in
                defer {
                    group.leave()
                }
                
                switch result {
                case .success(let model):
                    characters.append(model)
                case .failure(_):
                    break
                }
            }
        }
        
        group.notify(queue: .main) {
            self.dataTuple = (
                episode:episode,
                characters: characters
            )
            
        }
        
    }
}
