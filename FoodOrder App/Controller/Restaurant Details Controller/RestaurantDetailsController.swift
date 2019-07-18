//
//  RestaurantDetailsController.swift
//  FoodOrder App
//
//  Created by Milan Varasada on 11/07/19.
//  Copyright © 2019 Milan Varasada. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseAuth

//Mark :- struct for items
struct PopularItem {
    var PopularItemName = [String]()
    var PopularItemPrice = [String]()
    var opened = Bool()
    var title = String()
}


class RestaurantDetailsController: UIViewController {
    
    //Mark :- views
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet var main: UIView!
    
    //firebase Variable
    let storage = Storage.storage()
    let db = Firestore.firestore()
    
    //variables
    var PopularItems = [PopularItem]()
    var FeaturedItems : [FeaturedItem] = []
    var RestUID:Int = 0
    var rs:Double = 0.0
    var restaurantName = ""
    var doublestr  = ""
    var totalOrderPrice:String?
    
    //addButton for order
    @IBOutlet var orderLabel: UILabel!
    @IBOutlet var tableview: UITableView!
    
    //Mark :- outlets
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var ordeerNowButton: UIButton!
    @IBOutlet var freeDeliveryLabel: UILabel!
    @IBOutlet var bookmarkSave: UIButton!
    @IBOutlet var backButton: UIButton!
    @IBOutlet var headerImageView: UIImageView!
    @IBOutlet weak var restName: UILabel!
    @IBOutlet var scrollview: UIScrollView!
    @IBOutlet weak var restaurantAddress: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Initialization()
    }
    
    override func viewWillLayoutSubviews(){
        super.viewWillLayoutSubviews()
        scrollview.contentSize = CGSize(width:self.view.frame.width, height: self.view.frame.height + 300)
    }
    
  
    //Mark :- back button
    @IBAction func backButton(_ sender: Any) {
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: HomeViewController.self) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
    }
    
    //Mark :- add order button
    @IBAction func addOrder(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CheckOutViewController") as! CheckOutViewController
        guard let price = totalOrderPrice else {
            return
        }
        nextViewController.orderPrice = price
        print(nextViewController.orderPrice)
        navigationController?.pushViewController(nextViewController, animated: true)
    }
}

extension RestaurantDetailsController:UICollectionViewDelegate,UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(FeaturedItems.count)
        return FeaturedItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)  as? FeaturedItemCell
       {
        let index = FeaturedItems[indexPath.row]
        cell.FeaturedImageName.text = index.FeaturedItemName
        cell.FeaturedImagePrice.text = index.FeaturedItemPrice
        cell.FeaturedImage.image = index.FeaturedItemImage
        cell.FeaturedImage.layer.cornerRadius = 15
        cell.FeaturedImage.layer.masksToBounds = true
        return cell
        }
        else
       {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let image = FeaturedItems[indexPath.row].FeaturedItemImage
        let name = FeaturedItems[indexPath.row].FeaturedItemName
        let price = FeaturedItems[indexPath.row].FeaturedItemPrice
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "FeaturedItemDisplay") as! FeaturedItemDisplay
       print(image)
        print(name)
        print(price)
        nextViewController.name = name
        nextViewController.price = price
        nextViewController.image = image
        navigationController?.pushViewController(nextViewController, animated: true)
    }
}


extension RestaurantDetailsController:UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
            return CGSize(width: 200, height: 190)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
      
            return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
       
        
            return 0
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
       
            return 15
    }
}

extension RestaurantDetailsController : UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if PopularItems[section].opened == true
        {
            return PopularItems[section].PopularItemName.count + 1
        }
        else
        {
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0
        {
            print(indexPath.section)
            let cell = tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            print(PopularItems[indexPath.section].title)
            cell.textLabel!.text = PopularItems[indexPath.section].title
           
            return cell
        }
        else
        {
           if let cell = tableview.dequeueReusableCell(withIdentifier: "custom", for: indexPath) as? PopularItemCell
           {
           cell.NameLabel.text = PopularItems[indexPath.section].PopularItemName[indexPath.row - 1]
        cell.PriceLabel.text = PopularItems[indexPath.section].PopularItemPrice[indexPath.row - 1]
            cell.delegate = self
            cell.delegate2 = self
            cell.index = indexPath.row
            return cell
            }
            else
           {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
            return cell!
            }
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {

        return PopularItems.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableview.deselectRow(at: indexPath, animated: false)
        if indexPath.row == 0
        {
        if PopularItems[indexPath.section].opened == true
        {
            PopularItems[indexPath.section].opened = false
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none)
        }
        else
        {
            PopularItems[indexPath.section].opened = true
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none)
        }
    }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    

}
extension RestaurantDetailsController:PassPrice
{
   
    func pass(price: Double) {
        rs = rs + price
         doublestr = String(format: "%.2f", rs)
          totalOrderPrice = doublestr
        orderLabel.text = "$ \(doublestr)"
    }
    
    
}
extension RestaurantDetailsController:deleteprice
{
    func delete(price: Double) {
        rs = rs - price
        doublestr = String(format: "%.2f", rs)
        totalOrderPrice = doublestr
         orderLabel.text = "$ \(doublestr)"
    }
    
    
}

extension RestaurantDetailsController
{
    fileprivate func Initialization() {
        //headerImage
        headerImageView.image = UIImage(named: "brooke")
        let origImage = UIImage(named: "Left Icon")
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        backButton.setImage(tintedImage, for: .normal)
        backButton.tintColor = UIColor.white
        
        let oImage = UIImage(named: "bookmarkSave")
        let tintColor = oImage?.withRenderingMode(.alwaysTemplate)
        bookmarkSave.setImage(tintColor, for: .normal)
        bookmarkSave.tintColor = UIColor.white
        
        freeDeliveryLabel.layer.cornerRadius = 8
        freeDeliveryLabel.layer.masksToBounds = true
        
        ordeerNowButton.layer.cornerRadius = 10
        ordeerNowButton.layer.masksToBounds = true
        
        //Mark :- restaurant details
        restName.text = restaurantName
        
        
        let tintView = UIView()
        tintView.backgroundColor = UIColor(white: 0, alpha: 0.3) //change to your liking
        tintView.frame = CGRect(x: 0, y: 0, width: headerImageView.frame.width, height: headerImageView.frame.height)
        
        headerImageView.addSubview(tintView)
        
        let nib = UINib(nibName: "FeaturedItemCell", bundle: nil)
        collectionView?.register(nib, forCellWithReuseIdentifier: "cell")
        
        tableview.register(PopularItemCell.self, forCellReuseIdentifier: "cell")
        
        self.tableview.estimatedRowHeight = 70
        self.tableview.rowHeight = UITableView.automaticDimension
        tableview.delegate = self
        tableview.dataSource = self
        
        PopularItems = [PopularItem(PopularItemName:  ["Special Palaw","Lemon Spagg"], PopularItemPrice: ["5.00","5.00"], opened: false, title: "Popular Items"),PopularItem(PopularItemName:  ["Chicken 1","Chiken 2"], PopularItemPrice: ["10.00","10.00"], opened: false, title: "Chikens")]
        
        readData()
    }
}

extension RestaurantDetailsController
{
    func readData() {
        FeaturedItems = []
        db.collection("RestaurantDetails").document("\(RestUID)").collection("FItems").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    
                    let new = FeaturedItem()
                    new.FeaturedItemName = "\(document.data()["FeaturedItemName"] as! String)"
                    new.FeaturedItemPrice = "\(document.data()["FeaturedItemPrice"] as! String)"
                    new.FeaturedItemImageName = "\(document.documentID)"
                    let storageRef = Storage.storage().reference(withPath: "Images/\(document.documentID).png")
                    storageRef.getData(maxSize: 4 * 1024 * 1024) { data, error in
                        if let error = error {
                            print("error downloading image:\(error)")
                        } else {
                            
                            // Data for "images/island.jpg" is returned
                            new.FeaturedItemImage = UIImage(data: data!)
                            
                            self.FeaturedItems.append(new)
                            
                            self.collectionView.reloadData()
             
                        }
                    }
                }
            }
        }
        
    }
}
