//
//  Pagination.swift
//  Square1Cities
//
//  Created by Timothy Obeisun on 7/21/22.
//

import Foundation


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
