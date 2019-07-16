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
    let FilterArray = ["Open Now","Credit Cards","Free Delivery"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       let controller = Bottomsheet.Controller()
        controller.addTableView { [weak self] tableview in
            // tableView
        }
    }
    
    @IBAction func resetButton(_ sender: Any) {
    }
    
    @IBAction func doneButton(_ sender: Any) {
      
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "RestaurantsController") as! RestaurantsController
            self.navigationController?.pushViewController(nextViewController, animated: true)
        
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
        }
            
        else
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            cell.NameLabel.textColor =  UIColor(displayP3Red: 221.0/255.0, green: 55.0/255.0, blue: 91.0/255.0, alpha: 1.0)
        }
       
        if indexPath.section == 3
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        tableview.deselectRow(at: indexPath, animated: true)
    }
 
}
