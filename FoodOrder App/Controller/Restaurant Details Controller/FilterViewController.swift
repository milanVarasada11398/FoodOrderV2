//
//  FilterViewController.swift
//  FoodOrder App
//
//  Created by milan on 14/07/19.
//  Copyright © 2019 Milan Varasada. All rights reserved.
//

import UIKit
import BottomDrawer
import SwiftRangeSlider
import Bottomsheet

class FilterViewController: UIViewController {

    @IBOutlet var mainView: UIView!
    @IBOutlet weak var tableview: UITableView!
    let SortByArray = ["Top Rated","Nearest Me","Cost High to Low","Cost Low to High"]
    let FilterArray = ["Open Now","Credit Cards","Free delivery"]
    var filterarray : [String] = []
    var filterCuisine : [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
       let controller = Bottomsheet.Controller()
        controller.addTableView { [weak self] tableview in
            // tableView
        }
    }
    
    @IBAction func resetButton(_ sender: Any) {
      
        filterarray = []
        filterCuisine = []
            for section in 1..<self.tableview.numberOfSections - 1{
                for row in 0..<self.tableview.numberOfRows(inSection: section){
                    if let cell = self.tableview.cellForRow(at: IndexPath(row: row, section: section)) as? OtherFilerCell
                   {
                    cell.accessoryType = .none
                    cell.NameLabel.textColor = UIColor(displayP3Red: 38.0/255.0, green: 49.0/255.0, blue: 95.0/255.0, alpha: 1.0)
                    }
                }
            }
        for section in 0..<self.tableview.numberOfSections{
            for row in 0..<self.tableview.numberOfRows(inSection: section){
                if let cell = self.tableview.cellForRow(at: IndexPath(row: row, section: section)) as? CuisineCell
                {
                    for section in 0..<cell.collectionview.numberOfSections{
                        for row in 0..<cell.collectionview.numberOfItems(inSection: section){
                            if let cell1 = cell.collectionview.cellForItem(at: IndexPath(row: row, section: section)) as? CuisineCollectionViewCell
                            {
                                cell1.cuisineLabel.layer.borderColor = UIColor(displayP3Red: 199.0/255.0, green: 202.0/255.0, blue: 209.0/255.0, alpha: 1.0).cgColor
                                cell1.cuisineLabel.textColor = UIColor(displayP3Red: 199.0/255.0, green: 202.0/255.0, blue: 209.0/255.0, alpha: 1.0)
                            }
                        }
                    }
                    
                }
            }
        }
        
    }
    
    @IBAction func doneButton(_ sender: Any) {
        
        if filterarray.count == 0 && filterCuisine.count == 0
        {
            Alertview.instance.delegate = self
            Alertview.instance.showAlert(title: "Restaurant Not Found.", message: "You can filter again for best restaurants.", alertType: .Failure)
        }
        else
        {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "RestaurantsController") as! RestaurantsController
            nextViewController.filters = filterarray
            nextViewController.filterCuisine = filterCuisine
              print(nextViewController.filters)
            print(nextViewController.filterCuisine)
            self.navigationController?.pushViewController(nextViewController, animated: true)
    
        }
    }

 
}
extension FilterViewController : clickOnButton
{
    func clickContinueShoppingButton() {
         Alertview.instance.parentView.removeFromSuperview()
    }
}
extension FilterViewController : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0
        {
            return 1
        }
        else if section == 1
        {
        return SortByArray.count
        }
        else if section == 2
        {
            return FilterArray.count
        }
        else
        {
            return 1
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0
        {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CuisineCell
            cell.delegate = self
        return cell
        }
        else if indexPath.section == 1
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "sortCell", for: indexPath) as! OtherFilerCell
            cell.NameLabel.text = SortByArray[indexPath.row]
              cell.tintColor = UIColor(displayP3Red: 221.0/255.0, green: 55.0/255.0, blue: 91.0/255.0, alpha: 1.0)
            return cell
        }
        else if indexPath.section == 2
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "sortCell", for: indexPath) as! OtherFilerCell
            cell.NameLabel.text = FilterArray[indexPath.row]
            cell.tintColor = UIColor(displayP3Red: 221.0/255.0, green: 55.0/255.0, blue: 91.0/255.0, alpha: 1.0)
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "priceCell", for: indexPath) as! PriceFilterCell
            
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0
        {
        return 100
        }
        else if indexPath.section == 1
        {
            return 40
        }
        else if indexPath.section == 2
        {
            return 40
        }
        else
        {
            return 100
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0
        {
        return "CUISINES"
        }
        else if section == 1
        {
        return "SORT BY"
        }
        else if section == 2
        {
            return "FILTER"
        }
        else
        {
            return "PRICE"
        }
    }   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! OtherFilerCell
        
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            cell.NameLabel.textColor =  UIColor(displayP3Red: 38.0/255.0, green: 49.0/255.0, blue: 95.0/255.0, alpha: 1.0)
            filterarray.removeAll { $0 == "\(cell.NameLabel.text!)"}
            print(filterarray)
        }
            
        else
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            cell.NameLabel.textColor =  UIColor(displayP3Red: 221.0/255.0, green: 55.0/255.0, blue: 91.0/255.0, alpha: 1.0)
            filterarray.append(cell.NameLabel.text!)
            print(filterarray)
        }
       
        if indexPath.section == 3
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        
   tableview.deselectRow(at: indexPath, animated: true)
    }
 
   
}
extension FilterViewController : PassFilterArray
{
    func PassCuisine(cuisine: [String]) {
        filterCuisine = cuisine
    }
    
    
}
