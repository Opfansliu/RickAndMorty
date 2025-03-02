//
//  CharactersViewController.swift
//  RAndM
//
//  Created by mac on 2024/7/8.
//

import UIKit

final class CharactersViewController: UIViewController {
    
    private let characterListView = RMCharacterListView()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Character"
        view.backgroundColor = .systemBackground
        setUpView()
        addSearchButton()
    }
    
    private func addSearchButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearch))
    }
    
    @objc
    private func didTapSearch() {
        let vc = RMSearchViewController(config: RMSearchViewController.Config(type: .character))
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    private func setUpView(){
        view.addSubview(characterListView)
        characterListView.delegate = self
        NSLayoutConstraint.activate([
            characterListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            characterListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            characterListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            characterListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        
        ])
    }

}
//Mark -- didSelect
extension CharactersViewController: RMCharacterListViewDelete {
    func rmCharacterListView(_ listView: RMCharacterListView, didSelectCharacter character: RMCharacter) {
        let characterDetailViewModel = RMCharacterDetailViewViewModel(character: character)
        let characterDetailViewController = RMCharacterDetailViewController(viewModel: characterDetailViewModel)
        navigationController?.pushViewController(characterDetailViewController, animated: true)
    }
}
