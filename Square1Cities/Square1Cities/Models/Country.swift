//
//  Country.swift
//  Square1Cities
//
//  Created by Timothy Obeisun on 7/21/22.
//

import Foundation

// MARK: - Country
struct Country: Codable {
    let id: Int
    let name, code: String
    let continentID: Int
    
    enum CodingKeys: String, CodingKey {
        case id, name, code
        case continentID = "continent_id"
    }
}
