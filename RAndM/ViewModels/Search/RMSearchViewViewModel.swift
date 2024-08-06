//
//  RMSearchViewViewModel.swift
//  RAndM
//
//  Created by mac on 2024/8/2.
//

import UIKit
//Responsiblities
//- show search results
//- show no results view
//- show kick off api requests

final class RMSearchViewViewModel {
    
    public var config: RMSearchViewController.Config
    
    init(config: RMSearchViewController.Config) {
        self.config = config
    }

}
