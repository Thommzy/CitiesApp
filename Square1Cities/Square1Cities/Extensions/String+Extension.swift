//
//  String+Extension.swift
//  Square1Cities
//
//  Created by Timothy Obeisun on 7/21/22.
//

import Foundation

extension String {
    var asUrl: URL? {
        return URL(string: self)
    }
}

