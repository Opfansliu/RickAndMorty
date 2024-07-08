//
//  TabBarViewController.swift
//  RAndM
//
//  Created by mac on 2024/7/8.
//

import UIKit


class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configSubViewControllers()
        view.backgroundColor = .systemBackground
        
    }
    
    func configSubViewControllers() {
        let charactersVC = UINavigationController(rootViewController: CharactersViewController())
        let locationsVC =  UINavigationController(rootViewController: LocationsViewController())
        let episodesVC =  UINavigationController(rootViewController: EpisodesViewController())
        let settingsVC =  UINavigationController(rootViewController: SettingsViewController())
        
        charactersVC.title = "characters"
        charactersVC.tabBarItem.image = UIImage(systemName: "person")
        charactersVC.navigationBar.prefersLargeTitles = true
        
        locationsVC.title = "locations"
        locationsVC.tabBarItem.image = UIImage(systemName: "globe")
        locationsVC.navigationBar.prefersLargeTitles = true
        
        episodesVC.title = "episodes"
        episodesVC.tabBarItem.image = UIImage(systemName: "tv")
        episodesVC.navigationBar.prefersLargeTitles = true
        
        settingsVC.title = "settings"
        settingsVC.tabBarItem.image = UIImage(systemName: "gear")
        settingsVC.navigationBar.prefersLargeTitles = true

        
        self.viewControllers = [charactersVC, locationsVC, episodesVC, settingsVC]
        
    }
    

}
