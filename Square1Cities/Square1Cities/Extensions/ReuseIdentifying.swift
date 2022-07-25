//
//  ReuseIdentifying.swift
//  Square1Cities
//
//  Created by Timothy Obeisun on 7/24/22.
//

import UIKit

protocol ReuseIdentifying {
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifying {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}

extension UITableViewCell: ReuseIdentifying {
    public static func reuse(forTableView tableView: UITableView,
                             indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: Self.reuseIdentifier, for: indexPath)
    }
}
