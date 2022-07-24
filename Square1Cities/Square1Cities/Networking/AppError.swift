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
            return AppString.responseError.localisedValue
        case .unknownError:
            return AppString.unknownError.localisedValue
        case .serverError(let error):
            return error
        }
    }
}
