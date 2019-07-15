//
//  PopularItemCell.swift
//  FoodOrder App
//
//  Created by Milan Varasada on 12/07/19.
//  Copyright © 2019 Milan Varasada. All rights reserved.
//

import UIKit

protocol PassPrice {
    func pass(price:Double)
}
protocol deleteprice {
    func delete(price:Double)
}

class PopularItemCell: UITableViewCell {

    var index : Int = 0
    @IBOutlet var checkButton: UIButton!
    @IBOutlet var PriceLabel: UILabel!
    @IBOutlet var NameLabel: UILabel!
    var delegate:PassPrice!
    var delegate2:deleteprice!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func checkButtonClicked(_ sender: Any) {
        print(index)
        print(PriceLabel.text!)
        checkButton.isSelected = !checkButton.isSelected
        if((sender as AnyObject).isSelected == true)
        {
            (sender as AnyObject).setImage(UIImage(named: "checked"), for: .selected)
            var price = Double(PriceLabel.text!)
            print(price!)
            delegate.pass(price:price!)
        }
        else
        {
            (sender as AnyObject).setImage(UIImage(named: "uncheck"), for: .normal)
            var price = Double(PriceLabel.text!)
            print(price!)
            delegate2.delete(price: price!)
        }
//        var price = Double(PriceLabel.text!)
//        print(price!)
//        delegate.pass(price:price!)
    }
}
