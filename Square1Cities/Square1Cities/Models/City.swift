//
//  City.swift
//  Square1Cities
//
//  Created by Timothy Obeisun on 7/21/22.
//

import Foundation
import RealmSwift


// MARK: - Pagination
struct City: Codable {
    var id: Int
    var name: String
    let countryID: Int
    let country: Country?
    let lat: Double?
    let lng: Double?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case countryID = "country_id"
        case country
        case lat
        case lng
    }
}
