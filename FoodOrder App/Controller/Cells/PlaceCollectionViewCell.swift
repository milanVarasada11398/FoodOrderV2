//
//  PlaceCollectionViewCell.swift
//  FoodOrder App
//
//  Created by Milan Varasada on 09/07/19.
//  Copyright © 2019 Milan Varasada. All rights reserved.
//

import UIKit

class PlaceCollectionViewCell: UICollectionViewCell {

    @IBOutlet var placeImage: UIImageView!
    @IBOutlet var placeNameLabel: UILabel!
    @IBOutlet var AddressLabel: UILabel!
    @IBOutlet var bookmarkImage: UIImageView!
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var deliveryLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

}
