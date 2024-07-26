//
//  RMCharacterDetailViewViewModel.swift
//  RAndM
//
//  Created by mac on 2024/7/17.
//

import UIKit
import Foundation

final class RMCharacterDetailViewViewModel {
    private var charater: RMCharacter
    
    public var episodes: [String] {
        charater.episode
    }
    
    enum SectionType {
        case photos(viewModel: RMCharacterPhotoCollectionViewCellViewModel )
        case information(viewModels: [RMCharacterInfoCollectionViewCellViewModel])
        case episodes(viewModels:[RMCharacterEpisodeCollectionViewCellViewModel])
    }
    
    public var sections: [SectionType] = []
    
  
//  MARK: init
    init(character: RMCharacter) {
        self.charater = character
        setUpSections()
    }
    /**
     let id: Int
     let name: String
     let status: RMCharacterStatus
     let species: String
     let type: String
     let gender: RMCharacterGender
     let origin: RMOrigin
     let location: RMSingleLocation
     let image: String
     let episode: [String]
     let url: String
     let created: String
     */
    private func setUpSections() {
        sections = [
            .photos(viewModel: .init(imageURL: URL(string: charater.image))),
            .information(viewModels: [
                .init(value: charater.status.text, type: .status),
                .init(value: charater.gender.rawValue, type: .gender),
                .init(value: charater.species, type: .species),
                .init(value: charater.type, type: .type),
                .init(value: charater.origin.name, type: .origin),
                .init(value: charater.created, type: .created),
                .init(value: charater.location.name, type: .location),
                .init(value: "\(charater.episode.count)", type: .episodeCount),
                
            ]),
            .episodes(viewModels: charater.episode.compactMap({
                return RMCharacterEpisodeCollectionViewCellViewModel(episodeDataURL: URL(string: $0))
            }))
        ]
    }
    
    public var requestUrl:URL? {
        return URL(string: charater.url)
    }
    
    public var title: String {
        charater.name.uppercased()
    }

    // MARK: layout
    public func createPhotosCollectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(0.5)
        ),
        subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    public func createInfosCollectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 2,
            leading: 2,
            bottom: 2,
            trailing: 2
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(150)
        ),
        subitems: [item, item]
        )
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    public func createEpisodesCollectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 10,
            leading: 10,
            bottom: 10,
            trailing: 10
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.8),
            heightDimension: .absolute(150)
        ),
        subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
    
}
