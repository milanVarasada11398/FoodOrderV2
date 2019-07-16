//
//  FeaturedItemDisplay.swift
//  FoodOrder App
//
//  Created by Milan Varasada on 15/07/19.
//  Copyright © 2019 Milan Varasada. All rights reserved.
//

import UIKit

class FeaturedItemDisplay: UIViewController {
    
    //Mark : - variables
    var name = ""
    var price = ""
    var image : UIImage?

    @IBOutlet var NameLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NameLabel.text = name
        priceLabel.text = price
        imageView.image = image
       
    }
    

    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    

}
