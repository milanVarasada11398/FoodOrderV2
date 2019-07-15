//
//  RestarantDisplayCell.swift
//  FoodOrder App
//
//  Created by Milan Varasada on 10/07/19.
//  Copyright © 2019 Milan Varasada. All rights reserved.
//

import UIKit

class RestarantDisplayCell: UICollectionViewCell {
    @IBOutlet var restarantImage: UIImageView!
    @IBOutlet var saveBookMarkButton: UIButton!
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var cellView: UIView!
    @IBOutlet var FreeDeliveryLabel: UILabel!
    
    @IBOutlet var RestAddLabel: UILabel!
    @IBOutlet var RestNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
