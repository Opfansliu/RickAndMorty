//
//  EpisodesViewController.swift
//  RAndM
//
//  Created by mac on 2024/7/8.
//

import UIKit

final class RMEpisodesViewController: UIViewController, RMEpisodeListViewDelegate {
    
    private let episodeListView = RMEpisodeListView()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Episodes"
        view.backgroundColor = .systemBackground
        setUpView()
        addSearchButton()
    }
    
    private func addSearchButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearch))
    }
    
    @objc
    private func didTapSearch() {
        let vc = RMSearchViewController(config: .init(type: .episode))
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    private func setUpView(){
        view.addSubview(episodeListView)
        episodeListView.delegate = self
        NSLayoutConstraint.activate([
            episodeListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            episodeListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            episodeListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            episodeListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        
        ])
    }

}

extension RMEpisodesViewController {
    func rmEpisodeListView(_ listView: RMEpisodeListView, didSelectEpisode episode: RMEpisode) {
        let EpisodeDetailViewController = RMEpisodeDetailViewController(url: URL(string: episode.url))
        navigationController?.pushViewController(EpisodeDetailViewController, animated: true)
    }
}
