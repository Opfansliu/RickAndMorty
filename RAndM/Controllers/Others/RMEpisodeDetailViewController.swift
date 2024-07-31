//
//  RMEpisodeDetailViewController.swift
//  RAndM
//
//  Created by mac on 2024/7/25.
//

import UIKit

final class RMEpisodeDetailViewController: UIViewController {
    private let viewModel: RMEpisodeDetailViewModel
    private let detailView: RMEpisodeDetailView
     
    // MARK: - init
    init(url: URL?) {
        self.viewModel = .init(endpointUrl: url)
        self.detailView = RMEpisodeDetailView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Episode"
        view.addSubview(detailView)
        addConstrains()
        view.backgroundColor = .systemBackground
        detailView.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapShare))
        
        viewModel.delegate = self
        viewModel.fetchEpisodeData()
        
    }
    private func addConstrains() {
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            detailView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc 
    private func didTapShare() {
        
    }
    
}

extension RMEpisodeDetailViewController: RMEpisodeDetailViewModelDelete {
    func didFetchEpisodeDetails() {
        detailView.config(with: viewModel)
    }
}

extension RMEpisodeDetailViewController: RMEpisodeDetailViewDelete {
    func rmEpisodeDetailView(_ detailView: RMEpisodeDetailView, didSelect character: RMCharacter) {
        
        let characterDetailViewModel = RMCharacterDetailViewViewModel(character: character)
        let characterDetailViewController = RMCharacterDetailViewController(viewModel: characterDetailViewModel)
        characterDetailViewController.title = character.name
        characterDetailViewController.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(characterDetailViewController, animated: true)
        
    }
    
    
}
