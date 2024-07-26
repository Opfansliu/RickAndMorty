//
//  RMCharacterDetailViewController.swift
//  RAndM
//
//  Created by mac on 2024/7/17.
//

import UIKit

final class RMCharacterDetailViewController: UIViewController {
    private var viewModel: RMCharacterDetailViewViewModel
    
    private var detailView: RMCharacterDetailView
    
    init(viewModel:RMCharacterDetailViewViewModel) {
        self.viewModel = viewModel
        self.detailView = RMCharacterDetailView(frame: .zero, viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = viewModel.title
        view.addSubview(detailView)
       
        detailView.collectionView?.delegate = self
        detailView.collectionView?.dataSource = self
        configConstrians()
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "share",
            style: .plain,
            target: self,
            action:#selector(shareBtnClick)
        )
        
    }
    private func fetchCharacterInfo() {
        
    }
    
    @objc
    private func shareBtnClick() {
        
        
    }
    
    private func configConstrians() {
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            detailView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        
        ])
    }
}

//MARK: - CollectionView
extension RMCharacterDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sections = viewModel.sections[section]
        switch sections {
        case .photos(_):
            return 1
        case .episodes(let viewModels):
            return viewModels.count
        case .information(let viewModels):
            return viewModels.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sections = viewModel.sections[indexPath.section]
        switch sections {
        case .photos(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterPhotoCollectionViewCell.cellIdentifier, for:indexPath) as?  RMCharacterPhotoCollectionViewCell else {
                fatalError()
            }
            cell.config(with: viewModel)
            return cell
        case .episodes(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterEpisodeCollectionViewCell.cellIdentifier, for:indexPath) as? RMCharacterEpisodeCollectionViewCell else {
                fatalError()
            }
            cell.config(with: viewModels[indexPath.row])
            return cell
        case .information(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterInfoCollectionViewCell.cellIdentifier, for:indexPath) as? RMCharacterInfoCollectionViewCell else {
                fatalError()
            }
            cell.configure(with: viewModels[indexPath.row])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sections = viewModel.sections[indexPath.section]
        switch sections {
        case .photos,
            .information:
            break
        case .episodes:
            let episodes = self.viewModel.episodes
            let selection = episodes[indexPath.row]
            let vc = RMEpisodeDetailViewController(url: URL(string: selection))
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
