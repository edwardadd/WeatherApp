//
//  FavouriteTableViewCell.swift
//  WeatherApp
//
//  Created by Edward Addley on 23/10/2019.
//  Copyright © 2019 AddHop Ltd. All rights reserved.
//

import UIKit

class FavouriteTableViewCell: UITableViewCell {
    static let identifier = "FavouriteTableViewCell"

    @IBOutlet weak var locationLabel: UILabel!

    func configure(locationName: String) {
        locationLabel.text = locationName
    }
}
