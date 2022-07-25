//
//  CityTableViewCell.swift
//  Square1Cities
//
//  Created by Timothy Obeisun on 7/24/22.
//

import UIKit

class CityTableViewCell: UITableViewCell {
    @IBOutlet weak var flagLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(with model: CityRealm) {
        cityLabel.text = model.name
        countryLabel.text = model.countryName
        latitudeLabel.text = "\(model.lat)"
        longitudeLabel.text = "\(model.lng)"
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0,
                                                                     left: 0,
                                                                     bottom: 5,
                                                                     right: 0))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension CityTableViewCell {
    func flag(country:String) -> String {
        let base : UInt32 = 127397
        var s = ""
        for v in country.unicodeScalars {
            s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        return String(s)
    }
    
    func countryFlag(countryCode: String) -> String {
        let flagBase = UnicodeScalar("🇦").value - UnicodeScalar("A").value

        let flag = countryCode
            .uppercased()
            .unicodeScalars
            .compactMap({ UnicodeScalar(flagBase + $0.value)?.description })
            .joined()
        return flag
    }
}
