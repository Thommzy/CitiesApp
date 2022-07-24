//
//  UIView+Extension.swift
//  Square1Cities
//
//  Created by Timothy Obeisun on 7/21/22.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
}
