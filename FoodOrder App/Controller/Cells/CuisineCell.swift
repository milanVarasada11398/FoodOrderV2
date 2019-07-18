//
//  CuisineCell.swift
//  FoodOrder App
//
//  Created by milan on 14/07/19.
//  Copyright © 2019 Milan Varasada. All rights reserved.
//

import UIKit

class CuisineCell: UITableViewCell {

    @IBOutlet weak var collectionview: UICollectionView!
    var cuisineArray = ["American","Turkish","Asia","Fastfood","Pizza","Maxican"]
    var filterCuisine : [String] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.collectionview.delegate = self
        self.collectionview.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension CuisineCell : UICollectionViewDelegate,UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cuisineArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
       if let cell = collectionview.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as? CuisineCollectionViewCell
       {
        cell.cuisineLabel.text = cuisineArray[indexPath.row]
        cell.cuisineLabel.layer.borderWidth = 2
        cell.cuisineLabel.layer.borderColor = UIColor(displayP3Red: 199.0/255.0, green: 202.0/255.0, blue: 209.0/255.0, alpha: 1.0).cgColor
        cell.cuisineLabel.layer.cornerRadius = 15
        cell.cuisineLabel.layer.masksToBounds = true
        return cell
        }
        else
       {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(cuisineArray[indexPath.row])
        collectionView.deselectItem(at: indexPath, animated: false)
        let cell = collectionView.cellForItem(at: indexPath) as! CuisineCollectionViewCell
        
        if  cell.cuisineLabel.layer.borderColor == UIColor(displayP3Red: 221.0/255.0, green: 55.0/255.0, blue: 91.0/255.0, alpha: 1.0).cgColor
        {
             cell.cuisineLabel.layer.borderColor = UIColor(displayP3Red: 199.0/255.0, green: 202.0/255.0, blue: 209.0/255.0, alpha: 1.0).cgColor
            cell.cuisineLabel.textColor = UIColor(displayP3Red: 199.0/255.0, green: 202.0/255.0, blue: 209.0/255.0, alpha: 1.0)
            filterCuisine.removeAll { $0 == "\(cell.cuisineLabel.text!)"}
            print(filterCuisine)
           
        }
        else
        {
             cell.cuisineLabel.layer.borderColor = UIColor(displayP3Red: 221.0/255.0, green: 55.0/255.0, blue: 91.0/255.0, alpha: 1.0).cgColor
             cell.cuisineLabel.textColor = UIColor(displayP3Red: 221.0/255.0, green: 55.0/255.0, blue: 91.0/255.0, alpha: 1.0)
            filterCuisine.append(cell.cuisineLabel.text!)
            print(filterCuisine)
        }
    }
    
    
    
}
extension CuisineCell : UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: 100, height: 50)
        return size
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
     
        
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 0
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
      
            return 0
        
    }
    
}


