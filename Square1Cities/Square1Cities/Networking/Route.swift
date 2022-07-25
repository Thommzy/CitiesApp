//
//  Route.swift
//  Square1Cities
//
//  Created by Timothy Obeisun on 7/21/22.
//

import Foundation

enum Route {
    static let baseUrl  = AppString.baseURL.localisedValue
    case fetchCities(Int)
    case filterCity(String, Int)
    
    var description: String {
        switch self {
        case .fetchCities(let page):
            return "/v1/city?page=\(page)&include=country"
        case .filterCity(let searchParameter,
                         let page):
            return "/v1/city?\(AppString.nameContain.localisedValue)=\(searchParameter)&page=\(page)&include=country"
        }
    }
}
