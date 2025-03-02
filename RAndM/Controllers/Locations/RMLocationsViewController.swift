//
//  LocationsViewController.swift
//  RAndM
//
//  Created by mac on 2024/7/8.
//

import UIKit

final class RMLocationsViewController: UIViewController {
    
    private let primaryView = RMLocationView()
    
    private let viewModel = RMLocationViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        addSearchButton()
        view.addSubview(primaryView)
        addConstrains()
        title = "Location"
        viewModel.delegate = self
        viewModel.fetchLocations()
        primaryView.delegate = self

        // Do any additional setup after loading the view.
    }
    private func addSearchButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearch))
    }
    
    @objc
    private func didTapSearch() {
        let vc = RMSearchViewController(config: .init(type: .location))
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func addConstrains() {
        NSLayoutConstraint.activate([
            primaryView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            primaryView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            primaryView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            primaryView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension RMLocationsViewController: RMLocationViewModelDelete {
    func didFetchInitialLocations() {
        primaryView.config(with: viewModel)
    }
}

extension RMLocationsViewController: RMLocationViewDelete {
    func rmLocationView(_ locationView: RMLocationView, didSelect location: RMLocation) {
        let detailVC = RMLocationDetailViewController(location: location)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
