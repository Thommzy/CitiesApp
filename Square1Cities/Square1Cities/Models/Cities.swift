//
//  Cities.swift
//  Square1Cities
//
//  Created by Timothy Obeisun on 7/21/22.
//

import Foundation

// MARK: - Cities
struct Cities: Codable {
    let items: [Item]?
    let pagination: Pagination
}

// MARK: - Item
struct Item: Codable {
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

// MARK: - Pagination
struct Pagination: Codable {
    let currentPage, lastPage, perPage, total: Int
    
    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case lastPage = "last_page"
        case perPage = "per_page"
        case total
    }
}
