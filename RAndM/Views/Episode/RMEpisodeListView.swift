//
//  CharacterListView.swift
//  RAndM
//
//  Created by mac on 2024/7/16.
//

import Foundation
import UIKit

protocol RMEpisodeListViewDelegate: NSObject {
    func rmEpisodeListView(_ listView: RMEpisodeListView,
                             didSelectEpisode episode:RMEpisode)
}

final class RMEpisodeListView: UIView {
    
    public weak var delegate: RMEpisodeListViewDelegate?
    
    private let viewModel = RMEpisodeListViewViewModel()
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
        collectionView.register(RMCharacterEpisodeCollectionViewCell.self, forCellWithReuseIdentifier:RMCharacterEpisodeCollectionViewCell.cellIdentifier )
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
        viewModel.fetchEpisodes()
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
extension RMEpisodeListView: RMEpisodeListViewViewModelDelete {
    
    func didLoadInitialEpisodes() {
        self.collectionView.reloadData()
        self.spinner.stopAnimating()
        self.collectionView.isHidden = false
        UIView.animate(withDuration: 0.4) {
            self.collectionView.alpha = 1
        }
    }
    
    func didSelectEpisode(_ episode: RMEpisode) {
        delegate?.rmEpisodeListView(self, didSelectEpisode: episode)
    }
    
    func didMoreEpisodes(with newIndexPaths: [IndexPath]) {
        self.collectionView.reloadData()
//        self.collectionView.performBatchUpdates {
//            self.collectionView.insertItems(at: newIndexPaths)
//        }
    }
}
