//
//  City.swift
//  Square1Cities
//
//  Created by Timothy Obeisun on 7/21/22.
//

import Foundation

// MARK: - City
struct City: Codable {
    let id: Int
    let name, localName: String
    let lat, lng: Double?
    let countryID: Int
    let country: Country
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case localName = "local_name"
        case lat, lng
        case countryID = "country_id"
        case country
    }
}
