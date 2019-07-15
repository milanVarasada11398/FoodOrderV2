//
//  PriceFilterCell.swift
//  FoodOrder App
//
//  Created by milan on 14/07/19.
//  Copyright © 2019 Milan Varasada. All rights reserved.
//

import UIKit
import SwiftRangeSlider

class PriceFilterCell: UITableViewCell {

    @IBOutlet weak var priceRangeSlider: RangeSlider!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
