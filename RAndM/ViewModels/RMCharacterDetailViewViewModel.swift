//
//  RMCharacterDetailViewViewModel.swift
//  RAndM
//
//  Created by mac on 2024/7/17.
//

import UIKit
import Foundation

final class RMCharacterDetailViewViewModel {
    private var charater: RMCharacter
    
    init(character: RMCharacter) {
        self.charater = character
    }
    
    public var title: String {
        charater.name.uppercased()
    }
}
