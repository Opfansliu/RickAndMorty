//
//  CharaterListViewViewModel.swift
//  RAndM
//
//  Created by mac on 2024/7/16.
//
import UIKit
import Foundation

protocol RMCharaterListViewViewModelDelete: NSObject {
    func didLoadInitialCharacters()
    func didMoreCharacters(with newIndexPaths: [IndexPath])
    func didSelectCharacter(_ character: RMCharacter)
}

final class RMCharaterListViewViewModel: NSObject {
    public weak var viewModelDelegate: RMCharaterListViewViewModelDelete?
    private var characters: [RMCharacter] = [] {
        didSet {
            for character in characters {
                let viewModel = RMCharacterListViewCellViewModel(
                    characterName: character.name,
                    characterStatus: character.status,
                    characterImageUrl: URL(string: character.image)
                )
                if !cellViewModels.contains(viewModel) {
                    cellViewModels.append(viewModel)
                }
               
            }
        }
    }
    
    
    private var cellViewModels: [RMCharacterListViewCellViewModel] = []
    private var apiInfo: RMGetAllCharactersResponse.Info? = nil
    private var isLoadingMoreCharacters = false
    
    public func fetchCharacters() {
        RMServer.shared.execute(
            .listCharactersRequests,
            expecting: RMGetAllCharactersResponse.self
        ) { [weak self] result in
            switch result {
            case .success(let responseModel):
//                print("Example image url" + String(model.results.first?.image ?? "no image"))
                let result = responseModel.results
                self?.apiInfo = responseModel.info
                self?.characters = result
                DispatchQueue.main.async {
                    self?.viewModelDelegate?.didLoadInitialCharacters()
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    public func fetchAdditionalCharacters(_ url: URL) {
        guard !isLoadingMoreCharacters else {
            return
        }
        isLoadingMoreCharacters = true
        print("Fetching more characters")
        guard let request = RMRequest(url: url) else {
            isLoadingMoreCharacters = false
            print("Failed to create request")
            return
        }
        RMServer.shared.execute(request, expecting: RMGetAllCharactersResponse.self) { [weak self] result in
            guard let strongSelf = self else{
                return
            }
            switch result {
            case .success(let responseModel):
                let moreResults = responseModel.results
                strongSelf.apiInfo = responseModel.info
                let originalCount = strongSelf.characters.count
                let newCount = moreResults.count
                let total = originalCount+newCount
                let startingIndex = total - newCount
                let indexPathsToAdd: [IndexPath] = Array(startingIndex..<(startingIndex+newCount)).compactMap({
                    return IndexPath(row: $0, section: 0)
                })
                strongSelf.characters.append(contentsOf: moreResults)
                
                DispatchQueue.main.async {
                    strongSelf.viewModelDelegate?.didMoreCharacters(with: indexPathsToAdd)
                    strongSelf.isLoadingMoreCharacters = false
                }
            case .failure(let failure):
                print(String(describing: failure))
                self?.isLoadingMoreCharacters = false
            }
        }
    }
    public var shouldShowLoadMoreIndicator:Bool {
        return apiInfo?.next != nil
    }
}

extension RMCharaterListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterListViewCell.cellIdentifier, for: indexPath) as? RMCharacterListViewCell else {
            fatalError("unsupported cell")
        }
        cell.configure(with: cellViewModels[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 30) / 2
        return CGSize(
            width: width,
            height: width * 1.5
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let character = characters[indexPath.row]
        viewModelDelegate?.didSelectCharacter(character)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard shouldShowLoadMoreIndicator else {
            return .zero
        }
        
        return CGSize(width: collectionView.frame.width, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter, let footer = collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: RMFootLoadingCollectionReusableView.identifier,
            for: indexPath
        ) as? RMFootLoadingCollectionReusableView else {
            fatalError("Unsupported")
        }
        footer.startAnimating()
        return footer
    }

    
    
}

//MARK - ScrollView
extension RMCharaterListViewViewModel: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard shouldShowLoadMoreIndicator, 
                !isLoadingMoreCharacters,
              !cellViewModels.isEmpty,
              let nextUrlString = apiInfo?.next,
              let url = URL(string: nextUrlString) else {
            return
        }
        
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] t in
            let offset = scrollView.contentOffset.y
            let contentOfFrame = scrollView.frame.size.height
            let contentFrame = scrollView.contentSize.height
            
            if offset >= (contentFrame - contentOfFrame - 100) {
                self?.fetchAdditionalCharacters(url)
                
                
            }
            t.invalidate()
        }
        
        
        
    }
    
}



