//
//  RMCharacterInfoCollectionViewCellViewModel.swift
//  RAndM
//
//  Created by mac on 2024/7/22.
//

import Foundation
import SwiftUI

final class RMCharacterInfoCollectionViewCellViewModel {
    public let value: String
    private var type: `Type`
    public var title: String {
        self.type.displayTitle
        
    }
    static let dataFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSZ"
        formatter.timeZone = .current
        return formatter
    }()
    
    static let shortDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
    
    public var displayValue: String {
        if value.isEmpty {
            return "None"
        }
        if let date = Self.dataFormatter.date(from: value),
           type == .created {
            return Self.shortDateFormatter.string(from: date)
        }
        return value
    }
    
    
    
    var iconImage: UIImage? {
        return type.iconImage
    }
    
    var tintColor: UIColor {
        return type.tintColor
    }
    
    enum `Type`: String {
        case status
        case gender
        case type
        case species
        case origin
        case location
        case created
        case episodeCount
        
        var tintColor: UIColor {
            switch self {
            case .status:
                return .systemCyan
            case .gender:
                return .systemGray3
            case .type:
                return .systemBlue
            case .species:
                return .systemMint
            case .origin:
                return .systemPink
            case .location:
                return .systemTeal
            case .created:
                return .systemBrown
            case .episodeCount:
                return .systemFill
            }
        }
        
        var iconImage: UIImage? {
            switch self {
            case .status:
                return UIImage(systemName: "bell")
            case .gender:
                return UIImage(systemName: "bell")
            case .type:
                return UIImage(systemName: "bell")
            case .species:
                return UIImage(systemName: "bell")
            case .origin:
                return UIImage(systemName: "bell")
            case .location:
                return UIImage(systemName: "bell")
            case .created:
                return UIImage(systemName: "bell")
            case .episodeCount:
                return UIImage(systemName: "bell")
            }
        }
        
        var displayTitle: String {
            switch self {
            case .status,
                 .gender,
                 .type,
                 .species,
                 .origin,
                 .location,
                 .created:
                return rawValue
            case .episodeCount:
                return "Episode Count"
            }
        }
    }
    
    init(value: String,
         type: `Type`
    ) {
        self.value = value
        self.type = type
        
    }
}
