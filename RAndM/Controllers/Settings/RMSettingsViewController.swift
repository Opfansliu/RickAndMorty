//
//  SettingsViewController.swift
//  RAndM
//
//  Created by mac on 2024/7/8.
//

import UIKit
import SwiftUI
import SafariServices
import StoreKit

final class RMSettingsViewController: UIViewController {
    
    private var settingsSwiftUIController: UIHostingController<RMSettingView>?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Setting"
        addSwiftController()
    }
    
    private func addSwiftController() {
        let settingsSwiftUIController = UIHostingController(
            rootView: RMSettingView(viewModel:
                                        RMSettingsViewModel(
                                            cellViewModels:RMSettingsOption.allCases.compactMap({
                                                return RMSettingsCellViewModel(type: $0) {[weak self] option in
                                                    self?.handleWithOption(option: option)
                                                }
                                            })
                                        )
                                   )
            )
        addChild(settingsSwiftUIController)
        settingsSwiftUIController.didMove(toParent: self)
        
        view.addSubview(settingsSwiftUIController.view)
        settingsSwiftUIController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            settingsSwiftUIController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            settingsSwiftUIController.view.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            settingsSwiftUIController.view.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            settingsSwiftUIController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        
        ])
        
        self.settingsSwiftUIController = settingsSwiftUIController
        
    }
    
    private func handleWithOption(option: RMSettingsOption) {
        guard Thread.current.isMainThread else {
            return
        }
        if let url = option.targetUrl {
            let vc = SFSafariViewController(url: url)
            present(vc, animated: true)
            
        } else if option == .rateApp {
            if let windowScene = view.window?.windowScene {
                SKStoreReviewController.requestReview(in: windowScene)
            }
            
        }
        
    }
    

}
