//
//  ApiResponse.swift
//  Square1Cities
//
//  Created by Timothy Obeisun on 7/21/22.
//

import Foundation

struct ApiResponse<T: Decodable>: Decodable {
    let data: T?
}
