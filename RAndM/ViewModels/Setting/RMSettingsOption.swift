//
//  RMSettingsOption.swift
//  RAndM
//
//  Created by mac on 2024/7/30.
//

import Foundation
import UIKit

enum RMSettingsOption: CaseIterable {
    case rateApp
    case contactUs
    case terms
    case privacy
    case apiReference
    case viewSeries
    case viewCode
    
    var displayTitle: String {
        switch self {
        case .rateApp:
            "rateApp"
        case .contactUs:
            "contactUs"
        case .terms:
            "terms"
        case .privacy:
            "privacy"
        case .apiReference:
            "apiReference"
        case .viewSeries:
            "viewSeries"
        case .viewCode:
            "viewCode"
        }
    }
    
    var targetUrl: URL? {
        switch self {
        case .rateApp:
            return nil
        case .contactUs:
            return URL(string: "https://gist.github.com/twostraws/aa18008c3dd3997e133aa92bde2ad8c7")
        case .terms:
            return URL(string: "https://gist.github.com/twostraws/aa18008c3dd3997e133aa92bde2ad8c7")
        case .privacy:
            return URL(string: "https://gist.github.com/twostraws/aa18008c3dd3997e133aa92bde2ad8c7")
        case .apiReference:
            return URL(string: "https://gist.github.com/twostraws/aa18008c3dd3997e133aa92bde2ad8c7")
        case .viewSeries:
            return URL(string: "https://gist.github.com/twostraws/aa18008c3dd3997e133aa92bde2ad8c7")
        case .viewCode:
            return URL(string: "https://gist.github.com/twostraws/aa18008c3dd3997e133aa92bde2ad8c7")
        }
    }
    var iconContainerColor: UIColor {
        switch self {
        case .rateApp:
            return .systemRed
        case .contactUs:
            return .systemPink
        case .terms:
            return .systemBlue
        case .privacy:
            return .systemCyan
        case .apiReference:
            return .systemMint
        case .viewSeries:
            return .systemBrown
        case .viewCode:
            return .systemOrange
        }
    }
    
    var iconImage: UIImage? {
        switch self {
        case .rateApp:
            return UIImage(systemName: "star.fill")
        case .contactUs:
            return UIImage(systemName: "paperplane")
        case .terms:
            return UIImage(systemName: "doc")
        case .privacy:
            return UIImage(systemName: "lock")
        case .apiReference:
            return UIImage(systemName: "list.clipboard")
        case .viewSeries:
            return UIImage(systemName: "tv.fill")
        case .viewCode:
            return UIImage(systemName: "hammer.fill")
        }
    }
    
    
   
}
