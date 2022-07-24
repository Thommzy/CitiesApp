//
//  AppString.swift
//  Square1Cities
//
//  Created by Timothy Obeisun on 7/22/22.
//

import Foundation

public enum AppString:String {
    public var localisedValue:String {
        return self.rawValue.getLocalizedValue()
    }
    
    case cityTitle
    case ChalkboardSEBold
    case responseError
    case unknownError
    case get
    case baseURL
    case nameContain
    case stringifyError
}
