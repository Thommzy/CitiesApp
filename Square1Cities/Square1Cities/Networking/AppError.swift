//
//  AppError.swift
//  Square1Cities
//
//  Created by Timothy Obeisun on 7/21/22.
//

import Foundation

enum AppError: LocalizedError {
    case errorDecoding
    case unknownError
    case serverError(String)
    
    var errorDescription: String? {
        switch self {
        case .errorDecoding:
            return "Response could not be decoded"
        case .unknownError:
            return "Error is Unknown"
        case .serverError(let error):
            return error
        }
    }
}
