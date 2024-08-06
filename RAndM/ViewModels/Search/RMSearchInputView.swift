//
//  RMSearchInputView.swift
//  RAndM
//
//  Created by mac on 2024/8/2.
//

import UIKit

final class RMSearchInputViewModel {
    private let type: RMSearchViewController.Config.`Type`
    init(type: RMSearchViewController.Config.`Type`) {
        self.type = type
    }
    enum DynamicOptions: String {
        case status =  "Status"
        case gender = "Gender"
        case locationType = "Location Type"
    }
    
    public var hasDynamicOptions: Bool {
        switch self.type {
        case .character, .location:
            return true
        case .episode:
            return false
        }
    }
    
    public var options: [DynamicOptions] {
        switch self.type {
        case .character:
            return [.gender, .status]
        case .episode:
            return []
        case .location:
            return [.locationType]
        }
    }
    
    public var searchPlaceholderText: String {
        switch self.type {
        case .character:
            return "Character Name"
        case .episode:
            return "Episode title"
        case .location:
            return "Location name"
        }
    }



}
