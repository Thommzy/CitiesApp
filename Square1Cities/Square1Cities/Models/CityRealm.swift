//
//  CityRealm.swift
//  Square1Cities
//
//  Created by Timothy Obeisun on 7/23/22.
//

import Foundation
import RealmSwift

// MARK: - CityRealm
class CityRealm: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var countryID = 0
    @objc dynamic var countryName = ""
    @objc dynamic var code: String? = nil
    @objc dynamic var lat = 0.0
    @objc dynamic var lng = 0.0
    @objc dynamic var currentPage = 0
    @objc dynamic var lastPage = 0
}
