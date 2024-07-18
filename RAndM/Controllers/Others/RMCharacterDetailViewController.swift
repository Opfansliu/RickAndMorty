//
//  RMCharacterDetailViewController.swift
//  RAndM
//
//  Created by mac on 2024/7/17.
//

import UIKit

final class RMCharacterDetailViewController: UIViewController {
    private var viewModel: RMCharacterDetailViewViewModel
    
    init(viewModel:RMCharacterDetailViewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = viewModel.title
        // Do any additional setup after loading the view.
    }
    

}
