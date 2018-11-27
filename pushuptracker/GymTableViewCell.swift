//
//  GymTableViewCell.swift
//  pushuptracker
//
//  Created by Jared Alexander on 11/26/18.
//  Copyright © 2018 Jared Alexander. All rights reserved.
//

import UIKit

class GymTableViewCell: UITableViewCell {

    @IBOutlet weak var gymNameLabel: UILabel!
    @IBOutlet weak var gymLogoImage: UIImageView!
    @IBOutlet weak var gymAddressLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
