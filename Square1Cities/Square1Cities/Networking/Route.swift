//
//  Route.swift
//  Square1Cities
//
//  Created by Timothy Obeisun on 7/21/22.
//

import Foundation

enum Route {
    static let baseUrl  = AppString.baseURL.localisedValue
    static let nameContain = AppString.nameContain.localisedValue
    
    case fetchCities(Int)
    
    var description: String {
        switch self {
        case .fetchCities(let page):
            return "/v1/city?page=\(page)&include=country"
        }
    }
}
