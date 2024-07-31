//
//  RMSettingsCellViewModel.swift
//  RAndM
//
//  Created by mac on 2024/7/30.
//

import Foundation
import UIKit

struct RMSettingsCellViewModel: Identifiable {
    
    var id = UUID()
    public let type: RMSettingsOption
    
    public var onTapHander: (RMSettingsOption) -> Void
    
    //MARK: - init
    init(type: RMSettingsOption, onTapHander:@escaping (RMSettingsOption) -> Void ) {
        self.type = type
        self.onTapHander = onTapHander
    }
    
    //MARK: - public
    public var image: UIImage? {
        return type.iconImage
    }
    
    public var title: String {
        return type.displayTitle
    }
    
    public var iconContainerColor: UIColor {
        return type.iconContainerColor
    }
    
    
}
