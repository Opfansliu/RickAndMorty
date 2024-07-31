//
//  RMGetAllEpisodesResponse.swift
//  RAndM
//
//  Created by mac on 2024/7/26.
//

import UIKit

struct RMGetAllEpisodesResponse: Codable {
    struct Info:Codable {
        let count: Int
        let next: String
        let pages: Int?
        let prev: String?
    }
    
    let info: Info
    let results: [RMEpisode]
    
}
