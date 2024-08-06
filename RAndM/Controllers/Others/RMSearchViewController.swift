//
//  RMSearchViewController.swift
//  RAndM
//
//  Created by mac on 2024/7/29.
//

import UIKit

class RMSearchViewController: UIViewController {
    struct Config {
        enum `Type` {
            case character
            case episode
            case location
        }
        let type : `Type`
        
        var title: String {
            switch type {
            case .character:
                return "search character"
            case .episode:
                return "search episode"
            case .location:
                return "search location"
            }
        }
    }
    
    private let searchView : RMSearchView
    private let viewModel : RMSearchViewViewModel
    init(config: Config) {
        self.viewModel = RMSearchViewViewModel(config: config)
        self.searchView = RMSearchView(frame: .zero, viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = self.viewModel.config.title
        view.backgroundColor = .systemBackground
        view.addSubview(searchView)
        addConstrains()
        searchView.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "search",
            style: .done,
            target: self,
            action: #selector(didTapSearch)
        )
        

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchView.presentKeyboard()
    }
    
    @objc
    private func didTapSearch() {
        
    }
    
    private func addConstrains() {
        
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            searchView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            searchView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
        ])
        
    }
}

extension RMSearchViewController: RMSearchViewDelete {
    func rmRMSearchView(_ searchView: RMSearchView, didSelectOption model: RMSearchInputViewModel.DynamicOptions) {
//        viewMode
    }
}
