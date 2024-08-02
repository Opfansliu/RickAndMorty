//
//  RMEpisodeDetailViewController.swift
//  RAndM
//
//  Created by mac on 2024/7/25.
//

import UIKit

final class RMLocationDetailViewController: UIViewController {
    private let viewModel: RMLocationDetailViewModel
    private let detailView = RMLocationDetailView()
    private let location: RMLocation
     
    // MARK: - init
    init(location: RMLocation) {
        self.location = location
        self.viewModel = .init(endpointUrl: URL(string: location.url))
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Location"
        view.addSubview(detailView)
        addConstrains()
        view.backgroundColor = .systemBackground
        detailView.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapShare))
        
        viewModel.delegate = self
        viewModel.fetchLocationData()
        
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

extension RMLocationDetailViewController: RMLocationDetailViewModelDelete {
    
    func didFetchLocationDetails() {
        detailView.config(with: viewModel)
    }
}

extension RMLocationDetailViewController: RMLocationDetailViewDelete {
    func rmLocationDetailView(_ detailView: RMLocationDetailView, didSelect character: RMCharacter) {
        
        let characterDetailViewModel = RMCharacterDetailViewViewModel(character: character)
        let characterDetailViewController = RMCharacterDetailViewController(viewModel: characterDetailViewModel)
        characterDetailViewController.title = character.name
        characterDetailViewController.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(characterDetailViewController, animated: true)
        
    }
    
    
}
