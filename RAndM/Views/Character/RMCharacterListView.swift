//
//  CharacterListView.swift
//  RAndM
//
//  Created by mac on 2024/7/16.
//

import Foundation
import UIKit

protocol RMCharacterListViewDelete: NSObject {
    func rmCharacterListView(_ listView: RMCharacterListView, didSelectCharacter character:RMCharacter)
}

final class RMCharacterListView: UIView {
    
    public weak var delegate: RMCharacterListViewDelete?
    
    private let viewModel = RMCharaterListViewViewModel()
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(RMCharacterListViewCell.self, forCellWithReuseIdentifier:RMCharacterListViewCell.cellIdentifier )
        collectionView.register(RMFootLoadingCollectionReusableView.self, forSupplementaryViewOfKind:UICollectionView.elementKindSectionFooter, withReuseIdentifier: RMFootLoadingCollectionReusableView.identifier)
        collectionView.isHidden = true
        collectionView.alpha = 0
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubViews(collectionView, spinner)
        addConstraints()
        spinner.startAnimating()
        viewModel.fetchCharacters()
        setUpCollectionView()
        viewModel.viewModelDelegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    private func addConstraints() {
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        
        ])
        
    }
    private func setUpCollectionView() {
        collectionView.dataSource = viewModel
        collectionView.delegate = viewModel

    }
    
}
extension RMCharacterListView: RMCharaterListViewViewModelDelete {
    func didLoadInitialCharacters() {
        self.collectionView.reloadData()
        self.spinner.stopAnimating()
        self.collectionView.isHidden = false
        UIView.animate(withDuration: 0.4) {
            self.collectionView.alpha = 1
        }
    }
    
    func didSelectCharacter(_ character: RMCharacter) {
        delegate?.rmCharacterListView(self, didSelectCharacter: character)
    }
    
    func didMoreCharacters(with newIndexPaths: [IndexPath]) {
        self.collectionView.reloadData()
//        self.collectionView.performBatchUpdates {
//            self.collectionView.insertItems(at: newIndexPaths)
//        }
    }
}
