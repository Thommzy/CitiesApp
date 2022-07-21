//
//  Route.swift
//  Square1Cities
//
//  Created by Timothy Obeisun on 7/21/22.
//

import Foundation

enum Route {
    static let baseUrl  = "http://connect-demo.mobile1.io/square1/connect"
    static let nameContain = "filter[0][name][contains]"
    
    case fetchCities(Int)
    
    var description: String {
        switch self {
        case .fetchCities(let page):
            return "/v1/city?page=\(page)&include=country"
        }
    }
}
