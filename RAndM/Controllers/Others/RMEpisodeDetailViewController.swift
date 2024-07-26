//
//  RMEpisodeDetailViewController.swift
//  RAndM
//
//  Created by mac on 2024/7/25.
//

import UIKit

final class RMEpisodeDetailViewController: UIViewController {
    private let url: URL?
    
    // MARK: - init
    init(url: URL?) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Episode"
        view.backgroundColor = .systemCyan

        // Do any additional setup after loading the view.
    }
    

}
