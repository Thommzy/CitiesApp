//
//  Country.swift
//  Square1Cities
//
//  Created by Timothy Obeisun on 7/21/22.
//

import RealmSwift
import Foundation

// MARK: - Country
struct Country: Codable {
    let id: Int
    let name: String
    let code: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case code
    }
}
