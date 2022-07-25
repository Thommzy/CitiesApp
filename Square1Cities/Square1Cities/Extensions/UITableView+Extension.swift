//
//  UITableView+Extension.swift
//  Square1Cities
//
//  Created by Timothy Obeisun on 7/25/22.
//

import UIKit

extension UITableView
{
    func indexPathExists(indexPath:IndexPath) -> Bool {
        if indexPath.section >= self.numberOfSections {
            return false
        }
        if indexPath.row >= self.numberOfRows(inSection: indexPath.section) {
            return false
        }
        return true
    }
}
