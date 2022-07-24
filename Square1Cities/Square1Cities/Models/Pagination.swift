//
//  Pagination.swift
//  Square1Cities
//
//  Created by Timothy Obeisun on 7/21/22.
//

import Foundation

// MARK: - Pagination
struct Pagination: Codable {
    let currentPage, lastPage: Int
    
    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case lastPage = "last_page"
    }
}
