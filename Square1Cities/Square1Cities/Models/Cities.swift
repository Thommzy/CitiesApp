//
//  Cities.swift
//  Square1Cities
//
//  Created by Timothy Obeisun on 7/21/22.
//

import Foundation
import RealmSwift

// MARK: - Cities
struct Cities: Codable {
    let items: [City]
    let pagination: Pagination
}

// MARK: - CitiesRealm
class CitiesRealm: Object {
    let items = List<CityRealm>()
}
