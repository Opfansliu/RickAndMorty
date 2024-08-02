//
//  RMGetLocations.swift
//  RAndM
//
//  Created by mac on 2024/8/1.
//

import Foundation
struct RMGetAllLocationsResponse: Codable {
    struct Info:Codable {
        let count: Int
        let next: String
        let pages: Int?
        let prev: String?
    }
    
    let info: Info
    let results: [RMLocation]
    
}
