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
    
    func configure(with model: CityRealm) {
        cityLabel.text = model.name
        countryLabel.text = model.countryName
        latitudeLabel.text = "\(model.lat)"
        longitudeLabel.text = "\(model.lng)"
        flagLabel.text = flag(country: model.code ?? "")
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
}
