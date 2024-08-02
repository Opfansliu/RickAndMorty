//
//  RMLocationDetailViewModel.swift
//  RAndM
//
//  Created by mac on 2024/8/2.
//

import UIKit
protocol RMLocationDetailViewModelDelete: AnyObject {
    func didFetchLocationDetails()
}

final class RMLocationDetailViewModel {
    private let endpointUrl: URL?
    
    public weak var delegate: RMLocationDetailViewModelDelete?
    
    public var dataTuple: (location: RMLocation, characters:[RMCharacter])? {
        didSet {
            createCellViewModels()
            delegate?.didFetchLocationDetails()
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
        fetchLocationData()
    }
    
    //MARK: - public
    
    public func character(at index: Int) -> RMCharacter? {
        guard let dataTuple = dataTuple else { return nil }
        return dataTuple.characters[index]
    }

    
    //MARK: - private
    
    public func createCellViewModels() {
        guard let dataTuple = dataTuple else { return }
        let location = dataTuple.location
        let characters = dataTuple.characters
        var createdString = location.created
        if let createdData = RMCharacterInfoCollectionViewCellViewModel.dataFormatter.date(from: location.created) {
            createdString = RMCharacterInfoCollectionViewCellViewModel.shortDateFormatter.string(from: createdData)
        }
        
        cellViewModels = [
            .information(viewModels: [
                .init(title: "Location name", value: location.name),
                .init(title: "Location type", value: location.type),
                .init(title: "Location dimension", value: location.dimension),
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
    
    public func fetchLocationData() {
        guard let endpointUrl = endpointUrl else { return }
        guard let request = RMRequest(url: endpointUrl) else {
            return
        }
        
        RMServer.shared.execute(request, expecting: RMLocation.self) {[weak self] result in
            switch result {
            case .success(let model):
                self?.fetchRelatedCharacters(location: model)
            case .failure(let failure):
                print(String(describing: failure))
            }
        }
    }
    private func fetchRelatedCharacters(location: RMLocation) {
        let requests = location.residents.compactMap ({
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
                location:location,
                characters: characters
            )
            
        }
        
    }
}
