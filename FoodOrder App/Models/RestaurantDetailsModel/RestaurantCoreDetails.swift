//
//  RestaurantCoreDetails.swift
//  FoodOrder App
//
//  Created by Milan Varasada on 10/07/19.
//  Copyright © 2019 Milan Varasada. All rights reserved.
//

import Foundation
import UIKit

//Mark :- model for restaurant details

class Restaurant : Hashable  {
   
   
    var RestName : String = ""
    var RestAddress : String = ""
    var RestRating : String = ""
    var RestImage : UIImage?
    var RestImageName:String = ""
    var DeliveryType:String = ""
    var UID:Int = 0
    var hashValue: Int {
        return self.UID
    }
    
    static func == (lhs: Restaurant, rhs: Restaurant) -> Bool {
        return lhs.UID == rhs.UID
    }
    
   
}
