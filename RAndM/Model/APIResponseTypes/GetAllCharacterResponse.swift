//
//  GetAllCharacterResponse.swift
//  RAndM
//
//  Created by mac on 2024/7/16.
//

import Foundation
struct RMGetAllCharactersResponse: Codable {
    struct Info:Codable {
        let count: Int
        let next: String
        let pages: Int?
        let prev: String?
    }
    
    let info: Info
    let results: [RMCharacter]
    
}
