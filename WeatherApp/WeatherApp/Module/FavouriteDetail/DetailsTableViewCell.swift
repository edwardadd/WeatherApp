//
//  DetailsTableViewCell.swift
//  WeatherApp
//
//  Created by Edward Addley on 23/10/2019.
//  Copyright © 2019 AddHop Ltd. All rights reserved.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {
    static let identifier = "DetailsTableViewCell"

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!

    func configure(details: Details) {
        dateLabel.text = details.date
        windLabel.text = details.windDescription
    }
}
